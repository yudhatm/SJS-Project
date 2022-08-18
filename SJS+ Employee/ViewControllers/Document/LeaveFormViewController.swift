//
//  LeaveFormViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 12/05/22.
//

import UIKit
import DropDown
import RxSwift
import RxCocoa
import ProgressHUD

class LeaveFormViewController: SJSViewController, Storyboarded {
    var coordinator: HomeCoordinator?
    var viewModel: LeaveRequestViewModelType?
    
    @IBOutlet weak var requestTypeContainerView: UIView!
    @IBOutlet weak var dateContainerView: UIView!
    @IBOutlet weak var cutiKhususContainerView: UIView!
    
    @IBOutlet weak var requestTypeTextField: IconTextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var documentImageView: UIImageView!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var sisaCutiLabel: UILabel!
    @IBOutlet weak var sisaCutiLabelTop: NSLayoutConstraint!
    @IBOutlet weak var cutiKhususTextField: IconTextField!
    @IBOutlet weak var submitButton: SJSButton!
    
    var leaveTypeDataSource = ["Sakit", "Ijin", "Cuti Tahunan", "Cuti Khusus"]
    var cutiKhususDataSource = ["Pernikahan Karyawan", "Khitanan Anak Karyawan", "Menikahkan Anak", "Baptis Anak", "Istri Melahirkan/Keguguran", "Orang tua/Mertua meninggal", "Pasangan/Anak Meninggal", "Keagamaan"]
    var dropdown = DropDown()
    var cutiKhususDropdown = DropDown()
    
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    
    var bag = DisposeBag()
    
    var userData = UserDefaultManager.shared.getUserData()
    var placeholderLabel: UILabel!
    
    var currentPhotoImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        self.title = "Buat Pengajuan"
        
        requestTypeTextField.delegate = self
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        cutiKhususTextField.delegate = self
        
        dateContainerView.isHidden = true
        
        startDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        startDatePicker.preferredDatePickerStyle = .wheels
        endDatePicker.preferredDatePickerStyle = .wheels
        startDatePicker.addTarget(self, action: #selector(handleStartDatePicker), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(handleEndDatePicker), for: .valueChanged)
        
        startDateTextField.inputView = startDatePicker
        endDateTextField.inputView = endDatePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCameraAS))
        documentImageView.isUserInteractionEnabled = true
        documentImageView.addGestureRecognizer(tapGesture)
        documentImageView.contentMode = .center
        
        showSisaCuti(false)
        
        descTextView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Silahkan tulis keterangan..."
        placeholderLabel.font = .italicSystemFont(ofSize: (descTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        descTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (descTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.isHidden = !descTextView.text.isEmpty
        
        requestTypeTextField.layer.borderWidth = 1
        requestTypeTextField.layer.borderColor = UIColor(hexaRGB: "F2A83D")?.cgColor
        requestTypeTextField.layer.cornerRadius = 8
        cutiKhususTextField.layer.borderWidth = 1
        cutiKhususTextField.layer.borderColor = UIColor(hexaRGB: "F2A83D")?.cgColor
        cutiKhususTextField.layer.cornerRadius = 8
        descTextView.layer.borderWidth = 1
        descTextView.layer.borderColor = UIColor(hexaRGB: "#AEAEAE")?.cgColor
        descTextView.layer.cornerRadius = 8
        
        cutiKhususContainerView.isHidden = true
        
        submitButton.addTarget(self, action: #selector(submitRequest), for: .touchUpInside)
        
        setupDropdown()
        setupRx()
    }
    
    func setupRx() {
        viewModel?.submitRequestObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                ProgressHUD.dismiss()
                let alert = OverlayBuilder.createSimpleAlert(title: "Success", message: "Pengajuan berhasil dibuat") { action in
                    self.navigationController?.popViewController(animated: true)
                }
                self.coordinator?.showAlert(alert)
            })
            .disposed(by: bag)
        
        self.viewModel?.errorObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                ProgressHUD.dismiss()
                let errorAc = OverlayBuilder.createErrorAlert(message: error.localizedDescription)
                self.coordinator?.showAlert(errorAc)
            })
            .disposed(by: bag)
    }
    
    func setupDropdown() {
        dropdown.anchorView = requestTypeTextField
        dropdown.dataSource = leaveTypeDataSource
        
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            requestTypeTextField.text = item
            startDateTextField.text = ""
            endDateTextField.text = ""
            cutiKhususTextField.text = ""
            
            dateContainerView.isHidden = !item.contains("Cuti")
            cutiKhususContainerView.isHidden = !item.contains("Khusus")
            
            if item.contains("Tahunan") {
                self.showSisaCuti(true)
            } else {
                self.showSisaCuti(false)
            }
        }
        
        cutiKhususDropdown.anchorView = cutiKhususTextField
        cutiKhususDropdown.dataSource = cutiKhususDataSource
        
        cutiKhususDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            cutiKhususTextField.text = item
        }
    }
    
    @objc func handleStartDatePicker(sender: UIDatePicker) {
        startDateTextField.text = convertStartAndEndDate(date: sender.date)
    }
    
    @objc func handleEndDatePicker(sender: UIDatePicker) {
        endDateTextField.text = convertStartAndEndDate(date: sender.date)
    }
    
    func showSisaCuti(_ status: Bool) {
        guard let sisaCuti = self.userData?.value?.cuti_balance else { return }
        
        if status {
            self.sisaCutiLabel.text = "Sisa Cuti \(sisaCuti) Hari"
            self.sisaCutiLabelTop.constant = 8
        } else {
            self.sisaCutiLabel.text = ""
            self.sisaCutiLabelTop.constant = 0
        }
    }
    
    func convertStartAndEndDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    @objc func openCameraAS() {
        let ac = UIAlertController(title: "Pemilihan foto", message: "Pilih sumber foto", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Kamera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        ac.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.coordinator?.showAlert(ac)
    }
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @objc func submitRequest() {
        guard let text = requestTypeTextField.text, !text.isEmpty else {
            let alert = OverlayBuilder.createErrorAlert(message: "Jenis Pengajuan harus dipilih")
            self.coordinator?.showAlert(alert)
            return
        }
        
        if !cutiKhususContainerView.isHidden {
            guard let text = cutiKhususTextField.text, !text.isEmpty else {
                let alert = OverlayBuilder.createErrorAlert(message: "Jenis cuti khusus harus diisi")
                self.coordinator?.showAlert(alert)
                return
            }
        }
        
        if !dateContainerView.isHidden {
            guard let text = startDateTextField.text, !text.isEmpty else {
                let alert = OverlayBuilder.createErrorAlert(message: "Tanggal mulai harus diisi")
                self.coordinator?.showAlert(alert)
                return
            }
            
            guard let text = endDateTextField.text, !text.isEmpty else {
                let alert = OverlayBuilder.createErrorAlert(message: "Tanggal selesai harus diisi")
                self.coordinator?.showAlert(alert)
                return
            }
        }
        
        guard currentPhotoImage != nil else {
            let alert = OverlayBuilder.createSimpleAlert(title: "Error", message: "Harus ada foto")
            self.coordinator?.showAlert(alert)
            return
        }
        
        guard !descTextView.text.isEmpty else {
            let alert = OverlayBuilder.createErrorAlert(message: "Keterangan harus diisi")
            self.coordinator?.showAlert(alert)
            return
        }
        
        let userData = UserDefaultManager.shared.getUserData()
        let employeeId = userData?.value?.id_employee ?? ""
        let principleId = "1"
        let imageData = currentPhotoImage?.jpegData(compressionQuality: 0.5) ?? Data()
        let type = requestTypeTextField.text ?? ""
        
        var startDateString = ""
        var endDateString = ""
        
        if !dateContainerView.isHidden {
            let df = DateFormatter()
            df.timeZone = TimeZone(identifier: "id")
            df.dateFormat = "dd MMM yyyy"
            let startDate = df.date(from: startDateTextField.text ?? "01 Jan 2000")
            let endDate = df.date(from: endDateTextField.text ?? "01 Jan 2000")
            
            df.dateFormat = "yyyy-MM-dd"
            startDateString = df.string(from: startDate ?? Date())
            endDateString = df.string(from: endDate ?? Date())
        }
        
        let param: [String: Any] = ["id_employee": employeeId,
                                    "id_principle": principleId,
                                    "type": type,
                                    "start_date": startDateString,
                                    "end_date": endDateString
                                    ]
        
        ProgressHUD.show()
        self.viewModel?.postLeaveRequest(parameters: param, photoData: imageData, imageKeyName: "foto dokumen ijin", imageFileName: "foto dokumen ijin user \(userData?.value?.name_employee ?? "employee").png")
        
    }
}

extension LeaveFormViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == requestTypeTextField {
            dropdown.show()
            textField.resignFirstResponder()
            return false
        }
        
        if textField == cutiKhususTextField {
            cutiKhususDropdown.show()
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
}

extension LeaveFormViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self] in
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            //Setting image to your image view
            self?.documentImageView.contentMode = .scaleAspectFit
            self?.documentImageView.image = image
            self?.currentPhotoImage = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension LeaveFormViewController: UINavigationControllerDelegate {}

extension LeaveFormViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
