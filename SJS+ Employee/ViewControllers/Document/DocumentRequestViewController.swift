//
//  DocumentRequestViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 12/05/22.
//

import UIKit
import DropDown
import RxSwift
import RxCocoa

class DocumentRequestViewController: SJSViewController, Storyboarded {
    var coordinator: HomeCoordinator?
    var viewModel: DocumentViewModelType?
    
    @IBOutlet weak var documentTypeTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var documentTypeContainerView: UIView!
    @IBOutlet weak var descriptionContainerView: UIView!
    
    var documentTypeDataSource = ["Item"]
    var dropdown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        self.title = "Permintaan Dokumen"
        
        documentTypeTextField.delegate = self
        
        setupDropdown()
    }
    
    func setupDropdown() {
        dropdown.anchorView = documentTypeTextField
        dropdown.dataSource = documentTypeDataSource

        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            documentTypeTextField.text = item
        }
    }
}

extension DocumentRequestViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == documentTypeTextField {
            dropdown.show()
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
}
