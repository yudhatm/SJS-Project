//
//  RegularInViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 17/05/22.
//

import UIKit
import DropDown

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        self.title = "Regular In"
        cameraButton.addTarget(self, action: #selector(openCameraAS), for: .touchUpInside)
        shiftTextField.delegate = self
        shiftTextField.placeholder = "Pilih shift"
        setupDropDown()
    }
    
    private func setupDropDown() {
        var shiftDataSource: [String] = []
        
        dropdown.anchorView = shiftTextField
        dropdown.dataSource = shiftDataSource
        
        guard let shiftList = viewModel?.shiftList else {
            return
        }
        
        for item in shiftList {
            let itemString = "\(item.label ?? "") (\(item.inTime ?? "") - \(item.outTime ?? ""))"
            shiftDataSource.append(itemString)
        }

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
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension RegularInViewController: UINavigationControllerDelegate {
    
}
