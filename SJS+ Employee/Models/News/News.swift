//
//  News.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 28/07/22.
//

import Foundation

struct News: Convertable {
     var id: String?
     var namaUser: String?
     var status: String?
     var imageUrl: String?
     var description: String?
     var isLikeNews: Bool?
     var videoUrl: String?
     var profileUrl: String?
     var userId: String?
     var doc: String?
     var totalLike: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case namaUser = "nama_user"
        case status
        case imageUrl = "image_url"
        case description = "dekripsi"
        case isLikeNews = "is_like_news"
        case videoUrl = "video_url"
        case profileUrl = "profile_url"
        case userId = "id_user"
        case doc
        case totalLike = "total_like"
    }
}
