//
//  OverlayBuilder.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 29/04/22.
//

import Foundation
import LTHRadioButton

struct OverlayBuilder {
    static func createOverlayPicker() -> OverlayPickerViewController {
        let vc = OverlayPickerViewController()
        vc.modalPresentationStyle = .custom
        
        return vc
    }
    
    static func createSimpleAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        ac.addAction(okAction)
        
        return ac
    }
    
    static func createErrorAlert(message: String) -> UIAlertController {
        return createSimpleAlert(title: "Error", message: message, handler: nil)
    }
    
    static func createRadioButton() -> LTHRadioButton {
        let radioButton = LTHRadioButton(selectedColor: UIColor.appColor(.sjsOrange), deselectedColor: UIColor.appColor(.sjsTextGrey))
        
        return radioButton
    }
}
