//
//  Outlet.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 29/06/22.
//

import Foundation

struct Outlet: Convertable {
    var outlet: [OutletData]?
    var shift: [ShiftData]?
    var date: String?
    var time: String?
    var toleransi: Int?
}

struct OutletData: Convertable {
    var latitude: String?
    var longitude: String?
    var id: String?
    var code: String?
    var name: String?
    var provinceId: String?
    var cityId: String?
    var description: String?
    var province: String?
    var city: String?
    var distance: String?
    
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case id
        case code = "kode"
        case name = "nama"
        case provinceId = "id_provinsi"
        case cityId = "id_kota"
        case description = "keterangan"
        case province = "provinsi"
        case city = "kota"
        case distance
    }
}

struct ShiftData: Convertable {
    var id: String?
    var label: String?
    var inTime: String?
    var outTime: String?
    var doc: String?
    var status: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case label
        case inTime = "jam_masuk"
        case outTime = "jam_pulang"
        case doc
        case status
    }
}
