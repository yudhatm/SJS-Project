//
//  Menu.swift
//  SJS+ Employee
//
//  Created by Buana on 25/05/22.
//

import Foundation

struct Menu: Convertable {
    var menu: [MenuData]?
    var total_notif: Int
}

struct MenuData: Codable {
    var id: String?
    var nama_menu: String?
}
