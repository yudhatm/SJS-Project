//
//  User.swift
//  SJS+ Employee
//
//  Created by Buana on 20/05/22.
//

import Foundation

struct User: Convertable {
    var value: UserData?
}

struct UserData: Codable {
    var id_customer: String?
    var create_date: String?
    var id_employee: String?
    var name_employee: String?
    var nik_sjs: String?
    var nik_customer: String?
    var position: String?
    var no_ktp: String?
    var mobile_phone: String?
    var no_kk: String?
    var tax_number: String?
    var no_bpjs_tk: String?
    var no_bpjs_kes: String?
    var no_bpjs_pensiun: String?
    var marital_status: String?
    var end_contract_pkwt_1_suksesindo: String?
    var no_nik_couple: String?
    var name_couple: String?
    var name_child_1: String?
    var name_child_2: String?
    var name_child_3: String?
    var address: String?
    var current_living_address: String?
    var name_bank: String?
    var account_number_bank: String?
    var account_name_bank: String?
    var email: String?
    var biological_mother_name: String?
    var gender: String?
    var place_of_birth: String?
    var date_of_birth: String?
    var id_province: String?
    var id_regencie: String?
    var districts: String?
    var village: String?
    var postal_code: String?
    var education_level_1: String?
    var school_name_1: String?
    var department_1: String?
    var account_number_bank_path: String?
    var no_kk_path: String?
    var no_bpjs_tk_path: String?
    var no_bpjs_kes_path: String?
    var basic_salary: String?
    var cuti_balance: String?
    var cuti_taken: String?
    var cuti_leave: String?
    var nama_perusahaan: String?
    var id_principle: String?
    var status_employee: String?
    var name_province: String?
    var name_regencie: String?
}
