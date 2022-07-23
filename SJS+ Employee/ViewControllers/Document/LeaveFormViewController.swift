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

class LeaveFormViewController: SJSViewController, Storyboarded {
    var coordinator: HomeCoordinator?
    var viewModel: LeaveRequestViewModelType?

    @IBOutlet weak var requestTypeContainerView: UIView!
    @IBOutlet weak var dateContainerView: UIView!
    
    @IBOutlet weak var requestTypeTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var documentImageView: UIImageView!
    @IBOutlet weak var descTextView: UITextView!
    
    var leaveTypeDataSource = ["Cuti", "Ijin", "Sakit", "Off"]
    var dropdown = DropDown()
    
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        self.title = "Buat Pengajuan"
        
        requestTypeTextField.delegate = self
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
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
        
        setupDropdown()
    }
    
    func setupDropdown() {
        dropdown.anchorView = requestTypeTextField
        dropdown.dataSource = leaveTypeDataSource

        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            requestTypeTextField.text = item
            startDateTextField.text = ""
            endDateTextField.text = ""
            
            dateContainerView.isHidden = !(item == "Cuti")
        }
    }
    
    @objc func handleStartDatePicker(sender: UIDatePicker) {
        startDateTextField.text = convertStartAndEndDate(date: sender.date)
    }
    
    @objc func handleEndDatePicker(sender: UIDatePicker) {
        endDateTextField.text = convertStartAndEndDate(date: sender.date)
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
        self.present(ac, animated: true, completion: nil)
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
}

extension LeaveFormViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == requestTypeTextField {
            dropdown.show()
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
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension LeaveFormViewController: UINavigationControllerDelegate {}
