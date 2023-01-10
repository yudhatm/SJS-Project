//
//  IconTextField.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 02/08/22.
//

import Foundation
import UIKit

protocol IconTextFieldDelegate: UITextFieldDelegate {
    func textFieldIconClicked(btn:UIButton)
}

/// Text Field with editable icon. Icon can be set on the either side of the TextField.
@IBDesignable class IconTextField: UITextField {

    //Delegate when image/icon is tapped.
    private var myDelegate: IconTextFieldDelegate? {
        get { return delegate as? IconTextFieldDelegate }
    }

    @objc func buttonClicked(btn: UIButton){
        self.myDelegate?.textFieldIconClicked(btn: btn)
    }

    //Padding images on left
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += padding
        return textRect
    }

    //Padding images on Right
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= padding
        return textRect
    }

    @IBInspectable var padding: CGFloat = 0
    @IBInspectable var leadingImage: UIImage? { didSet { updateView() }}
    @IBInspectable var color: UIColor = UIColor.lightGray { didSet { updateView() }}
    @IBInspectable var imageColor: UIColor = UIColor(hexaRGB: "#3EB2FF") ?? .black { didSet { updateView() }}
    @IBInspectable var rightIcon: Bool = false { didSet { updateView() }}

    func updateView() {
        rightViewMode = .never
        rightView = nil
        leftViewMode = .never
        leftView = nil

        if let image = leadingImage {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)

            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            button.setImage(tintedImage, for: .normal)
            button.tintColor = imageColor

            button.setTitleColor(UIColor.clear, for: .normal)
            button.addTarget(self, action: #selector(buttonClicked(btn:)), for: .touchDown)
            button.isUserInteractionEnabled = true

            if rightIcon {
                rightViewMode = .always
                rightView = button
            } else {
                leftViewMode = .always
                leftView = button
            }
        }

        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[.foregroundColor: color])
    }
}
