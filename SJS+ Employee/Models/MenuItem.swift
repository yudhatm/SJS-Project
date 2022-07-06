//
//  Menu.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 06/07/22.
//

import Foundation

struct MenuItem: Convertable {
    var icon: String?
    var id: String?
    var menuName: String?
    
    init(icon: String?, id: String?, menuName: String?) {
        self.icon = icon
        self.id = id
        self.menuName = menuName
    }
    
    private enum CodingKeys: String, CodingKey {
        case icon
        case id
        case menuName = "nama_menu"
    }
}
