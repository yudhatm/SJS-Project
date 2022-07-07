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

protocol AbsensiViewModelType {
    var errorObs: Observable<Error> { get }
    var outletListObs: Observable<[OutletData]> { get }
    
    var lat: Double { get set }
    var lng: Double { get set }
    var shiftList: [ShiftData] { get set }
    
    func getOutletList()
}

final class AbsensiViewModel: AbsensiViewModelType {
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    lazy var outletListObs: Observable<[OutletData]> = outletListSubject.asObservable()
    
    var errorSubject = PublishSubject<Error>()
    var outletListSubject = PublishSubject<[OutletData]>()
    
    var lat: Double = 0.0
    var lng: Double = 0.0
    var shiftList: [ShiftData] = []
    
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
}
