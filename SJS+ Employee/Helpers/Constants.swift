//
//  Constants.swift
//  SJS+ Employee
//
//  Created by Buana on 29/04/22.
//

import Foundation

public typealias ViewSize = Constants.ViewSize
public typealias Constraints = Constants.Constraints
public typealias CornerRadius = Constants.CornerRadius

public struct Constants {
    public struct ViewSize {
        static let threeQuarterScreen = 0.75
        static let halfScreen = 0.5
        static let oneQuarterScreen = 0.25
    }
    
    public struct Constraints {
        static let margin8: CGFloat = 8
        static let margin12: CGFloat = 12
        static let margin16: CGFloat = 16
        static let margin20: CGFloat = 20
        static let margin24: CGFloat = 24
    }
    
    public struct CornerRadius {
        static let radius8: CGFloat = 8
        static let radius12: CGFloat = 12
        static let radius24: CGFloat = 24
    }
}
