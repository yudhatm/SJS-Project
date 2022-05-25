//
//  UserDefaultManager.swift
//  SJS+ Employee
//
//  Created by Buana on 25/05/22.
//

import Foundation

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
}