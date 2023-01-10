//
//  UserDefaultManager.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 25/05/22.
//

import Foundation
import SwiftyJSON

/// Manager class that simplifies User Default functions.
class UserDefaultManager {
    static var shared = UserDefaultManager()
    
    let userDefault = UserDefaults.standard
    
    func saveObject(_ object: Any, key: String) {
        userDefault.set(object, forKey: key)
        print("[UserDefaultManager] Object \(key) is saved")
    }
    
    func saveClassObject(_ object: Convertable, key: String) {
        let dict = object.convertToDict()
        userDefault.set(dict, forKey: key)
        print("[UserDefaultManager] Class object \(key) is saved")
    }
    
    func loadObject(key: String) -> Any? {
        guard let data = userDefault.object(forKey: key) else {
            print("[UserDefaultManager] ERROR: Load object with key \(key) failed")
            return nil
        }
        
        return data
    }
    
    func removeObject(key: String) {
        userDefault.removeObject(forKey: key)
        print("[UserDefaultManager] Object \(key) is removed")
    }
    
    func decodeJSON<T: Codable>(json: JSON?) -> T? {
        guard let json = json else {
            print("no JSON to be decoded")
            return nil
        }

        if let data: T? = DecodeHelper().decode(json: json) {
            return data
        } else {
            return nil
        }
    }
    
    func getData(key: Constants.UserDefaultsKey) -> JSON? {
        if let data = UserDefaultManager.shared.loadObject(key: key.rawValue) as? Dictionary<String, Any> {
            return JSON(data)
        } else {
            return nil
        }
    }
    
    func getUserData() -> User? {
        let json = self.getData(key: .userData)
        return decodeJSON(json: json)
    }
    
    func saveCurrentWorkplaceData(data: OutletData) {
        self.saveClassObject(data, key: UserDefaultsKey.currentWorkplaceData.rawValue)
    }
    
    func getCurrentWorkplaceData() -> OutletData? {
        let json = getData(key: .currentWorkplaceData)
        return decodeJSON(json: json)
    }
    
    func saveCurrentShiftData(data: ShiftData) {
        self.saveClassObject(data, key: UserDefaultsKey.currentShiftData.rawValue)
    }
    
    func getCurrentShiftData() -> ShiftData? {
        let json = getData(key: .currentShiftData)
        return decodeJSON(json: json)
    }
}
