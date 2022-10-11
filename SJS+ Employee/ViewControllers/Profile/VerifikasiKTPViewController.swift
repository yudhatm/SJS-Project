//
//  VerifikasiKTPViewController.swift
//  SJS+ Employee
//
//  Created by Yudha on 11/10/22.
//

import UIKit

class VerifikasiKTPViewController: SJSViewController, Storyboarded {
    var coordinator: ProfileCoordinator?
    
    @IBOutlet weak var ktpImageView: UIImageView!
    @IBOutlet weak var kirimButton: SJSButton!
    @IBOutlet weak var bulletListLabel: UILabel!
    @IBOutlet weak var checklistButton: UIButton!
    
    var isChecklistActive = false {
        didSet {
            checklistButton.tintColor = !isChecklistActive ? UIColor.gray : UIColor.appColor(.sjsOrange)
        }
    }
    
    var bulletListTexts = [
        "Pastikan KTP kamu terlihat jelas di kamera",
        "Verifikasi KTP hanya berlaku 1 kali",
        "Biaya verifikasi KTP sebesar Rp 25.000"
    ]
    
    var currentPhotoImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.title = LocalizeEnum.verifikasiKTPTitle.rawValue.localized()
        
        bulletListLabel.attributedText = Helper.bulletPointList(strings: bulletListTexts)
        checklistButton.tintColor = !isChecklistActive ? UIColor.gray : UIColor.appColor(.sjsOrange)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCameraAS))
        ktpImageView.isUserInteractionEnabled = true
        ktpImageView.addGestureRecognizer(tapGesture)
        ktpImageView.contentMode = .center
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
    
    @IBAction func kirimButtonTapped(_ sender: Any) {
        //TODO: Open Payment Method
    }
    
    @IBAction func checklistButtonTapped(_ sender: Any) {
        isChecklistActive = !isChecklistActive
    }
}

extension VerifikasiKTPViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self] in
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            //Setting image to your image view
            self?.ktpImageView.contentMode = .scaleAspectFit
            self?.ktpImageView.image = image
            self?.currentPhotoImage = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension VerifikasiKTPViewController: UINavigationControllerDelegate {}
