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
}
