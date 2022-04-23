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
