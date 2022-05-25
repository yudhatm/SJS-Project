//
//  DecodeHelper.swift
//  SJS+ Employee
//
//  Created by Buana on 25/05/22.
//

import Foundation
import SwiftyJSON

struct DecodeHelper {
    func decode<T: Codable>(json: JSON) -> T? {
        let decoder = JSONDecoder()
        
        do {
            let data = try decoder.decode(T.self, from: json.rawData())
            return data
        }
        catch {
            print(error)
            return nil
        }
    }
}
