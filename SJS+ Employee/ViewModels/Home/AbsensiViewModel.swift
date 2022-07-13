//
//  AbsensiViewModel.swift
//  SJS+ Employee
//
//  Created by Yudha on 02/06/22.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

protocol AbsensiViewModelType {
    var errorObs: Observable<Error> { get }
    var outletListObs: Observable<[OutletData]> { get }
    var regularInObs: Observable<JSON> { get }
    
    var lat: Double { get set }
    var lng: Double { get set }
    var shiftList: [ShiftData] { get set }
    var selectedOutlet: OutletData? { get set }
    
    func getOutletList()
    func postRegularIn(parameters: [String: Any], photoData: Data, imageKeyName: String, imageFileName: String)
}

final class AbsensiViewModel: AbsensiViewModelType {
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    lazy var outletListObs: Observable<[OutletData]> = outletListSubject.asObservable()
    lazy var regularInObs: Observable<JSON> = regularInSubject.asObservable()
    
    var errorSubject = PublishSubject<Error>()
    var outletListSubject = PublishSubject<[OutletData]>()
    var regularInSubject = PublishSubject<JSON>()
    
    var lat: Double = 0.0
    var lng: Double = 0.0
    var shiftList: [ShiftData] = []
    var selectedOutlet: OutletData?
    
    private var bag = DisposeBag()
    
    func getOutletList() {
        if let userData = UserDefaultManager.shared.getUserData() {
            let employeeId = userData.value?.id_employee ?? "0"
            
            let url = URLs.outletList + employeeId + "/\(lat)" + "/\(lng)"
            let obs: Observable<Outlet> = NetworkManager.shared.APIRequest(.get, url: url)
            
            obs.subscribe(onNext: { data in
                if let outletData = data.outlet {
                    self.outletListSubject.onNext(outletData)
                } else {
                    self.outletListSubject.onNext([])
                }
                
                self.shiftList = data.shift ?? []
            }, onError: { error in
                print("error: \(error.localizedDescription)")
            }, onCompleted: {
                print("get outlet completed")
            })
            .disposed(by: bag)
        }
    }
    
    func postRegularIn(parameters: [String: Any], photoData: Data, imageKeyName: String, imageFileName: String) {
        let url = URLs.absenRegularIn
        let obs: Observable<JSON> = NetworkManager.shared.APIUploadRequest(.post, encoding: JSONEncoding.default, url: url, parameters: parameters, uploadData: photoData, imageName: imageFileName, imageKeyName: imageKeyName)
        
        obs.subscribe(onNext: { data in
//            if let outletData = data.outlet {
//                self.outletListSubject.onNext(outletData)
//            } else {
//                self.outletListSubject.onNext([])
//            }
            
//            self.shiftList = data.shift ?? []
            print("absen success")
            print("absen data: \n\(data)")
            self.regularInSubject.onNext(data)
        }, onError: { error in
            print("error: \(error.localizedDescription)")
        }, onCompleted: {
            print("post regular in completed")
        })
        .disposed(by: bag)
    }
}
