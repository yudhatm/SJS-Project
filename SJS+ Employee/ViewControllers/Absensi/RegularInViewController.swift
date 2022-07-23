//
//  RegularInViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 17/05/22.
//

import UIKit
import DropDown
import RxSwift
import ProgressHUD

class RegularInViewController: SJSViewController, Storyboarded {
    weak var coordinator: HomeCoordinator?
    var viewModel: AbsensiViewModelType?
    
    @IBOutlet weak var shiftTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var cameraImage: UIImageView!
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var absenButton: SJSButton!
    
    let dropdown = DropDown()
    var selectedShift: ShiftData?
    
    var currentPhotoImage: UIImage?
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupRx()
    }
    
    private func configureView() {
        self.title = "Regular In"
        cameraButton.addTarget(self, action: #selector(openCameraAS), for: .touchUpInside)
        shiftTextField.delegate = self
        shiftTextField.placeholder = "Pilih shift"
        setupDropDown()
        
        absenButton.addTarget(self, action: #selector(postAbsen), for: .touchUpInside)
        
        if let isAbsenIn = viewModel?.isAlreadyAbsenRegularIn, isAbsenIn == true {
            self.title = "Regular Out"
            shiftTextField.isUserInteractionEnabled = false
            
            if let item = viewModel?.shiftList.first {
                let shiftName = "\(item.label ?? "") (\(item.inTime ?? "") - \(item.outTime ?? ""))"
                shiftTextField.text = shiftName
            } else {
                shiftTextField.text = ""
            }
        }
    }
    
    func setupRx() {
        self.viewModel?.regularInObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { json in
                ProgressHUD.dismiss()
                let ac = OverlayBuilder.createSimpleAlert(title: "Sukses", message: "Absen berhasil!") { action in
                    self.coordinator?.backToHome()
                }
                self.coordinator?.showAlert(ac)
            }, onError: { error in
                ProgressHUD.dismiss()
                let errorAc = OverlayBuilder.createErrorAlert(message: error.localizedDescription)
                self.coordinator?.showAlert(errorAc)
            }, onCompleted: {
            })
            .disposed(by: bag)
    }
    
    private func setupDropDown() {
        var shiftDataSource: [String] = []
        
        guard let shiftList = viewModel?.shiftList else {
            return
        }
        
        for item in shiftList {
            let itemString = "\(item.label ?? "") (\(item.inTime ?? "") - \(item.outTime ?? ""))"
            shiftDataSource.append(itemString)
        }
        
        dropdown.anchorView = shiftTextField
        dropdown.dataSource = shiftDataSource

        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            shiftTextField.text = item
            
            for shiftItem in shiftList {
                if item.contains(shiftItem.label ?? "") {
                    self.selectedShift = shiftItem
                }
            }
        }
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
    
    @objc func postAbsen() {
        guard shiftTextField.text != "" else {
            let alert = OverlayBuilder.createSimpleAlert(title: "Error", message: "Shift harus dipilih")
            self.present(alert, animated: true)
            return
        }

        guard let currentPhotoImage = currentPhotoImage else {
            let alert = OverlayBuilder.createSimpleAlert(title: "Error", message: "Harus ada foto")
            self.present(alert, animated: true)
            return
        }

        let imageData = currentPhotoImage.jpegData(compressionQuality: 0.5) ?? Data()
        
        let userData = UserDefaultManager.shared.getUserData()
        
        let employeeId = userData?.value?.id_employee ?? ""
        let principleId = "1"
        let outletId = viewModel?.selectedOutlet?.id ?? ""
        let shiftId = selectedShift?.id ?? ""
        let absenType = "regular"
        let lat = "\(viewModel?.lat ?? 0.0)"
        let lolat = "\(viewModel?.lng ?? 0.0)"
        
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: "id")
        df.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let str = df.string(from: Date())
        let localeDate = df.date(from: str) ?? Date()
        
        df.dateFormat = "yyyy-MM-dd"
        let tanggal = df.string(from: localeDate)
        
        df.dateFormat = "HH:mm:ss"
        let time = df.string(from: localeDate)
        
        let param: [String: Any] = ["id_employee": employeeId,
                                    "id_principle": principleId,
                                    "id_outlet": outletId,
                                    "id_shift": shiftId,
                                    "tgl": tanggal,
                                    "time": time,
                                    "type_ci": "CI",
                                    "type": absenType,
                                    "id": "0",
                                    "lat": lat,
                                    "lolat": lolat,
                                    "approve_by": "0"
                                    ]
        
        ProgressHUD.show()
        self.viewModel?.postRegularIn(parameters: param, photoData: imageData, imageKeyName: "fotoAbsen", imageFileName: "foto absen \(userData?.value?.name_employee ?? "employee").png")
    }
}

extension RegularInViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropdown.show()
        textField.resignFirstResponder()
        return false
    }
}

extension RegularInViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true) { [weak self] in
            
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            //Setting image to your image view
            self?.photoImageView.image = image
            self?.cameraImage.isHidden = true
            self?.currentPhotoImage = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension RegularInViewController: UINavigationControllerDelegate {
    
}
