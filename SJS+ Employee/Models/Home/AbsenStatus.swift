//
//  AbsenStatus.swift
//  SJS+ Employee
//
//  Created by Buana on 27/05/22.
//

import Foundation

struct AbsenStatus: Convertable {
    var textMessage: String?
    var textHexColor: String?
    var isAbsen: Bool?
    var jamMasuk: String?
    var jamPulang: String?
    
    private enum CodingKeys: String, CodingKey {
        case textMessage = "text_message"
        case textHexColor = "text_color"
        case isAbsen = "isabsen"
        case jamMasuk = "jam_masuk"
        case jamPulang = "jam_pulang"
    }
}
