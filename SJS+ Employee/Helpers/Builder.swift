//
//  OverlayBuilder.swift
//  SJS+ Employee
//
//  Created by Buana on 29/04/22.
//

import Foundation

struct OverlayBuilder {
    static func createOverlayPicker() -> OverlayPickerViewController {
        let vc = OverlayPickerViewController()
        vc.modalPresentationStyle = .custom
        
        return vc
    }
    
    static func createSimpleAlert(title: String, message: String) -> UIAlertController {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(okAction)
        
        return ac
    }
    
    static func createErrorAlert(message: String) -> UIAlertController {
        return createSimpleAlert(title: "Error", message: message)
    }
}
