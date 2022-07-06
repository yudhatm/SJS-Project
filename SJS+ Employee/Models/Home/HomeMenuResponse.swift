//
//  HomeMenuResponse.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 06/07/22.
//

import Foundation

struct HomeMenuResponse: Convertable {
    var menuData: [MenuItem]?
    var totalNotif: Int?
    
    private enum CodingKeys: String, CodingKey {
        case menuData = "menu"
        case totalNotif = "total_notif"
    }
}
