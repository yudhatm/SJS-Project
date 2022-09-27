//
//  Constants.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 29/04/22.
//

import Foundation

public typealias ViewSize = Constants.ViewSize
public typealias Constraints = Constants.Constraints
public typealias CornerRadius = Constants.CornerRadius
public typealias InfoPlistKeys = Constants.InfoPlistKeys
public typealias URLs = Constants.URLs
public typealias UserDefaultsKey = Constants.UserDefaultsKey
public typealias VariableKeys = Constants.VariableKeys

public struct Constants {
    public struct URLs {
//        #if DEBUG
//            static let baseURL = "https://dev-api-employee.kerjaplus.id/public/"
//        #else
//            static let baseURL = "https://api.sjsplus.id/public/p3/"
//        #endif
        
        static let baseURL = "https://api.sjsplus.id/public/p3/"
        static let users = "users/"
        
        static let loginURL = baseURL + users + "login"
        static let menuURL = baseURL + users + "menuapp2/1/"
        static let todayAbsenStatusURL = baseURL + users + "getabsentoday/"
        static let promoListURL = baseURL + users + "promotion/"
        static let outletList = baseURL + users + "absen/"
        static let newMenuUrl = baseURL + users + "menuapp/home/{{id_customer}}/{{id_user}}"
        static let newProfileMenuUrl = baseURL + users + "menuapp/account/{{id_customer}}/{{id_user}}"
        static let absenRegularIn = baseURL + users + "absen/insert"
        static let absenRepost = baseURL + users + "absenreport/{{id_user}}"
        static let pengajuan = baseURL + users + "sakit/{{id_user}}"
        static let insertPengajuan = baseURL + users + "sakitinsert"
        static let documents = baseURL + users + "doclist/{{id_user}}"
        static let insertDocument = baseURL + users + "doc"
        static let listBerita = baseURL + users + "berita/{{id_user}}//0"
        static let likeBerita = baseURL + users + "likeberita"
        static let slipGaji = baseURL + users + "slipgaji/{{id_user}}/{{month}}/{{year}}"
        static let surveyPage = baseURL + "survey/tahap{{page}}"
    }
    
    public enum VariableKeys: String {
        case customerId = "{{id_customer}}"
        case userId = "{{id_user}}"
        case month = "{{month}}"
        case year = "{{year}}"
        case page = "{{page}}"
    }
    
    public struct ViewSize {
        static let threeQuarterScreen = 0.75
        static let halfScreen = 0.5
        static let oneQuarterScreen = 0.25
    }
    
    public struct Constraints {
        static let margin8: CGFloat = 8
        static let margin12: CGFloat = 12
        static let margin16: CGFloat = 16
        static let margin20: CGFloat = 20
        static let margin24: CGFloat = 24
    }
    
    public struct CornerRadius {
        static let radius8: CGFloat = 8
        static let radius12: CGFloat = 12
        static let radius24: CGFloat = 24
    }
    
    public struct InfoPlistKeys {
        static let gmapAPIKey = "GMAP_API_KEY"
    }
    
    public enum UserDefaultsKey: String {
        case userData = "user_data"
        case currentWorkplaceData = "current_workplace_data"
        case currentShiftData = "current_shift_data"
    }
    
    public enum BackButtonColor: String {
        case white
        case black
    }
}

enum StatusPengajuan {
    case approved, waiting, rejected, undefined
}
