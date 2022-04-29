//
//  Extensions.swift
//  SJS+ Employee
//
//  Created by Yudha on 23/04/22.
//

import UIKit

enum AssetsColor {
    case sjsOrange
    case sjsBlue
    case sjsTextGrey
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .sjsOrange:
            return UIColor(named: "SJSAccentColor") ?? UIColor.orange
        case .sjsBlue:
            return UIColor(named: "SJSBlueColor") ?? UIColor.blue
        case .sjsTextGrey:
            return UIColor(named: "SJSTextGray") ?? UIColor.darkGray
        }
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}
