//
//  SJSButton.swift
//  SJS+ Employee
//
//  Created by Rizal Hidayat on 09/02/22.
//

import UIKit
import ObjectiveC

enum IconPosition {
    case left, right
}

/// Custom made button for SJS use.
@IBDesignable class SJSButton: UIButton {
    
    // MARK: - Properties
    
    private var normalColorHandle: UInt8 = 0
    private var disabledColorHandle: UInt8 = 0
    private var highlightedColorHandle: UInt8 = 0
    private var selectedColorHandle: UInt8 = 0
    
    /// Providing default value for button properties
    private var _buttonState: UIControl.State = .normal
    private var _borderColor: UIColor = .black
    private var _titleColor: UIColor = .white
    private var _borderWidth: CGFloat = 1
    private var _iconPosition: IconPosition = .left
    private var _buttonIcon: UIImage = UIImage()
    private var _gradientColor: UIColor = .clear
    private var _originalButtonTitle: String?
    private var _code: Int?
    
    override var buttonType: UIButton.ButtonType {
        return .custom
    }
    
    private var buttonState: UIControl.State {
        set(state) {
            self._buttonState = state
        }
        get { return self._buttonState }
    }
    
    @IBInspectable public var buttonIcon: UIImage {
        set(image) {
            self._buttonIcon = image
            self.setButtonIcon(with: self._buttonIcon)
        }
        get { return self._buttonIcon }
    }
    
    @IBInspectable public var leftIconAligment: Bool {
        get { return self._iconPosition == .left }
        set {
            self._iconPosition = newValue ? .left : .right
            self.setButtonIcon(with: self.buttonIcon, position: self._iconPosition)
        }
    }
    
    public var iconAlignment: IconPosition {
        set(value) {
            self._iconPosition = value
            self.setButtonIcon(with: self.buttonIcon, position: self._iconPosition)
        }
        get { return self._iconPosition }
    }
    
    @IBInspectable public var borderColors: UIColor {
        set(color) {
            self._borderColor = color
            self.layer.borderColor = self._borderColor.cgColor
            self.layer.borderWidth = self._borderWidth
        }
        get { return _borderColor }
    }
    
    @IBInspectable public var title: String {
        set(title) {
            self.setTitle(title, for: .normal)
            self.titleLabel?.textAlignment = .center
        }
        get { return "Button Title" }
    }
    
    @IBInspectable public var titleColor: UIColor {
        set(color) {
            self._titleColor = color
            self.setTitleColor(color, for: .normal)
        }
        get { return self._titleColor }
    }
    
    public var code: Int {
        set(code) { self._code = code }
        get { return self._code ?? 0}
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        set(value) { self.layer.cornerRadius = value }
        get { return 0 }
    }
    
    @IBInspectable public var borderWidths: CGFloat {
        set(value) {
            self._borderWidth = value
            self.layer.borderWidth = self._borderWidth
            self.layer.borderColor = self.borderColors.cgColor
        }
        get { return self._borderWidth }
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helpers
    
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    private func setBackgroundColor(with color: UIColor, for state: UIControl.State, gradientColor gradient: UIColor = .clear) {
        self.clipsToBounds = true
        self.buttonState = state
        self.setBackgroundImage(image(withColor: color), for: self.buttonState)
    }
    
    private func setButtonBorder(with color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    private func setButtonIcon(with image: UIImage, for state: UIControl.State = .normal, position: IconPosition = .left) {
        self.setImage(image.withRenderingMode(.alwaysOriginal), for: state)
        
        if let imageView = self.imageView {
            imageView.tintColor = self.titleColor
            imageView.contentMode = .scaleAspectFit
            self.bringSubviewToFront(imageView)
        }
        
        if position == .left {
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            self.semanticContentAttribute = .forceLeftToRight
        } else {
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
            self.semanticContentAttribute = .forceRightToLeft
        }
    }
}

// MARK: - Extension
extension SJSButton {
    
    @IBInspectable
    var color: UIColor? {
        get {
            if let color = objc_getAssociatedObject(self, &normalColorHandle) as? UIColor {
                return color
            }
            return nil
        }
        set {
            if let color = newValue {
                self.setBackgroundColor(with: color, for: .normal)
                objc_setAssociatedObject(self, &normalColorHandle, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            } else {
                self.setBackgroundImage(nil, for: .normal)
                objc_setAssociatedObject(self, &normalColorHandle, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    @IBInspectable
    var disabledColor: UIColor? {
        get {
            if let color = objc_getAssociatedObject(self, &disabledColorHandle) as? UIColor {
                return color
            }
            return nil
        }
        set {
            if let color = newValue {
                self.setBackgroundColor(with: color.withAlphaComponent(0.5), for: .disabled)
                objc_setAssociatedObject(self, &disabledColorHandle, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            } else {
                self.setBackgroundImage(nil, for: .disabled)
                objc_setAssociatedObject(self, &disabledColorHandle, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    @IBInspectable
    var highlightedColor: UIColor? {
        get {
            if let color = objc_getAssociatedObject(self, &highlightedColorHandle) as? UIColor {
                return color
            }
            return nil
        }
        set {
            if let color = newValue {
                self.setBackgroundColor(with: color, for: .highlighted)
                objc_setAssociatedObject(self, &highlightedColorHandle, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.setTitleColor(self.titleColor.withAlphaComponent(0.5), for: .highlighted)
            } else {
                self.setBackgroundImage(nil, for: .highlighted)
                objc_setAssociatedObject(self, &highlightedColorHandle, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    @IBInspectable
    var selectedColor: UIColor? {
        get {
            if let color = objc_getAssociatedObject(self, &selectedColorHandle) as? UIColor {
                return color
            }
            return nil
        }
        set {
            if let color = newValue {
                self.setBackgroundColor(with: color, for: .selected)
                objc_setAssociatedObject(self, &selectedColorHandle, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            } else {
                self.setBackgroundImage(nil, for: .selected)
                objc_setAssociatedObject(self, &selectedColorHandle, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
