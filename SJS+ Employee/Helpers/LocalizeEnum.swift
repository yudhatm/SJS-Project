//
//  LocalizeEnum.swift
//  SJS+ Employee
//
//  Created by Yudha on 25/08/22.
//

import Foundation

///Helper enum for getting Localize string.
enum LocalizeEnum: String {
    //MARK: - View Title
    case sjsTitle = "sjs_title"
    case homeTitle = "home_title"
    case penggajianTitle = "penggajian_title"
    case beritaTitle = "berita_title"
    case profileTitle = "profile_title"
    case createPostTitle = "create_post_title"
    case slipGajiTitle = "slip_gaji_title"
    case surveyTitle = "survey_title"
    case validasiDataTitle = "validasi_data_title"
    case verifikasiKTPTitle = "verifikasi_ktp_title"
    case homeCheckingTitle = "home_check_title"
    
    //MARK: - Create Post View
    case statusPlaceholder = "status_placeholder"
    
    //MARK: - Report Absensi
    case reportAbsensiTitle = "report_absensi_title"
    case absensiTerlambat = "absensi_terlambat"
    case totalJamKerja = "total_jam_kerja"
    case sisaCuti = "sisa_cuti"
    
    //MARK: - Slip Gaji
    case unduhSlip = "Unduh Slip";
    
    //MARK: - General Text
    case kirim = "kirim"
}
