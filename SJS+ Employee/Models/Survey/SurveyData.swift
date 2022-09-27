//
//  SurveyData.swift
//  SJS+ Employee
//
//  Created by Yudha on 27/09/22.
//

import Foundation

struct SurveyData: Convertable {
    var pertanyaan: [SurveyQuestion]
    var header: SurveyHeader
}

struct SurveyHeader: Convertable {
    var idKategori: String?
    var waktuPengerjaan: String?
    var type: String?
    var totalSoal: String?
    var status: String?
    var doc: String?
    var fassingGrade: String?
    var namaModul: String?
    var id: String?
    
    private enum CodingKeys: String, CodingKey {
        case idKategori = "id_kategori"
        case waktuPengerjaan = "waktu_pengerjaan"
        case type
        case totalSoal = "total_soal"
        case status
        case doc
        case fassingGrade = "fassing_grade"
        case namaModul = "nama_modul"
        case id
    }
}
