//
//  HomeViewModel.swift
//  SJS+ Employee
//
//  Created by Buana on 25/05/22.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

protocol HomeViewModelType {
    var absenStatusObs: Observable<AbsenStatus> { get }
    var promoObs: Observable<[Promo]> { get }
    var errorObs: Observable<Error> { get }
    
    func getAbsenStatus()
    func getPromoList()
}

final class HomeViewModel: HomeViewModelType {
    lazy var absenStatusObs: Observable<AbsenStatus> = absenStatusSubject.asObservable()
    lazy var promoObs: Observable<[Promo]> = promoSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var absenStatusSubject = PublishSubject<AbsenStatus>()
    var promoSubject = PublishSubject<[Promo]>()
    var errorSubject = PublishSubject<Error>()
    
    private var bag = DisposeBag()
    
    init() {
        getAbsenStatus()
        getPromoList()
    }
    
    func getAbsenStatus() {
        if let userData = UserDefaultManager.shared.getUserData() {
            let employeeId = userData.value?.id_employee ?? "0"
            
            let url = URLs.todayAbsenStatusURL + employeeId
            let obs: Observable<AbsenStatus> = NetworkManager.shared.APIRequest(.get, url: url)
            
            obs.subscribe(onNext: { data in
                print(data)
                self.absenStatusSubject.onNext(data)
            }, onError: { error in
                print(error)
                self.errorSubject.onNext(error)
            }, onCompleted: {
                print("get absen status completed")
            })
            .disposed(by: bag)
        }
    }
    
    func getPromoList() {
        let url = URLs.promoListURL + "0"
        let obs: Observable<[Promo]> = NetworkManager.shared.APIRequest(.get, url: url)
        
        obs.subscribe(onNext: { data in
            print(data)
            self.promoSubject.onNext(data)
        }, onError: { error in
            print(error)
            self.errorSubject.onNext(error)
        }, onCompleted: {
            print("get promo list completed")
        })
        .disposed(by: bag)
    }
}
