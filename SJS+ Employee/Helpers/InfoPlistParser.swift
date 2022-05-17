//
//  InfoPlistParser.swift
//  SJS+ Employee
//
//  Created by Buana on 17/05/22.
//

import Foundation

struct InfoPlistParser {
    static func getStringValue(forKey key: String) -> String {
        guard let value = Bundle.main.infoDictionary?[key] as? String else {
            fatalError("Could not find value for key \(key) in Info.plist")
        }
        
        return value
    }
}
