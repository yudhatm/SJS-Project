//
//  Menu.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 25/05/22.
//

import Foundation
import IGListKit

class Menu: NSObject, Convertable {
    var menu: [MenuData]?
    var total_notif: Int
    
    init(menu: [MenuData] = [], total_notif: Int = 0) {
        self.menu = menu
        self.total_notif = total_notif
    }
}

extension Menu: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }

}

class MenuData: ListDiffable, Codable {
    var id: String?
    var nama_menu: String?
    
    init(id: String = "", nama_menu: String = "") {
        self.id = id
        self.nama_menu = nama_menu
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        let id = id ?? ""
        return id as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let obj = object as? MenuData else { return false }
        return self.nama_menu == obj.nama_menu
    }
}
