//
//  ImageAsset.swift
//  SJS+ Employee
//
//  Created by Yudha on 24/08/22.
//

import Foundation
import UIKit

struct ImageAsset {
    enum AssetName: String {
        case likeEmpty = "empty_heart"
        case likeFilled = "filled_heart"
    }
    
    static func getImage(_ name: AssetName) -> UIImage {
        return UIImage(named: name.rawValue)!
    }
}
