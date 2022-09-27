//
//  SurveyQuestion.swift
//  SJS+ Employee
//
//  Created by Yudha on 27/09/22.
//

import Foundation

struct SurveyQuestion: Convertable {
    var jawaban: [SurveyAnswer]?
    var idSoalHeader: String?
    var questionImage: String?
    var status: String?
    var doc: String?
    var imagePath: String?
    var idKunciJawaban: String?
    var id: String?
    var pertanyaan: String?
    
    private enum CodingKeys: String, CodingKey {
        case jawaban
        case idSoalHeader = "id_soal_header"
        case questionImage = "pertanyaan_img"
        case status
        case doc
        case imagePath = "path_img"
        case idKunciJawaban = "id_kunci_jawaban"
        case id
        case pertanyaan
    }
}

struct SurveyAnswer: Convertable {
    var value: String?
    var image: String?
    var status: String?
    var id: String?
    var doc: String?
    var idPertanyaan: String?
    var jawabanText: String?
    var keyJawaban: String?
    var imagePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case value
        case image
        case status
        case id
        case doc
        case idPertanyaan = "id_pertanyaan"
        case jawabanText = "nama_jawaban"
        case keyJawaban = "key_jawaban"
        case imagePath = "path_image"
    }
}
