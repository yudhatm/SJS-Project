//
//  Convertable.swift
//  SJS+ Employee
//
//  Created by Buana on 25/05/22.
//

import Foundation

/// Define protocol to convert Struct or Class to Dictionary
protocol Convertable: Codable {
}

extension Convertable {
    /// implement convert Struct or Class to Dictionary
    func convertToDict() -> Dictionary<String, Any>? {

        var dict: Dictionary<String, Any>? = nil

        do {
            let encoder = JSONEncoder()

            let data = try encoder.encode(self)
            print("Struct/class converted to data")

            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>

        } catch {
            print(error)
        }

        return dict
    }
}
