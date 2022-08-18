//
//  HomeViewModel.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 25/05/22.
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
    var menuListObs: Observable<[MenuItem]> { get }
    var beritaListObs: Observable<[News]> { get }
    
    func getAbsenStatus()
    func getPromoList()
    func getListBerita()
}

final class HomeViewModel: HomeViewModelType {
    lazy var absenStatusObs: Observable<AbsenStatus> = absenStatusSubject.asObservable()
    lazy var promoObs: Observable<[Promo]> = promoSubject.asObservable()
    lazy var menuListObs: Observable<[MenuItem]> = menuItemSubject.asObservable()
    lazy var beritaListObs: Observable<[News]> = beritaListSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var absenStatusSubject = PublishSubject<AbsenStatus>()
    var promoSubject = PublishSubject<[Promo]>()
    var menuItemSubject = PublishSubject<[MenuItem]>()
    var beritaListSubject = PublishSubject<[News]>()
    var errorSubject = PublishSubject<Error>()
    
    private var bag = DisposeBag()
    
    init() {
        getAbsenStatus()
        getPromoList()
        getMainMenu()
        getListBerita()
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
    
    func getMainMenu() {
        var url = URLs.newMenuUrl
        
        if let userData = UserDefaultManager.shared.getUserData() {
            let customerId = userData.value?.id_customer
            let userId = userData.value?.id_employee
            
            url = url.replacingOccurrences(of: Constants.VariableKeys.customerId.rawValue, with: customerId ?? "")
            url = url.replacingOccurrences(of: Constants.VariableKeys.userId.rawValue, with: userId ?? "")
        }
        
        let obs: Observable<JSON> = NetworkManager.shared.APIRequestJSON(.get, url: url)
        
        obs.subscribe(onNext: { data in
            let items = data["menu"].arrayValue
            var menuList: [MenuItem] = []
            
            for item in items {
                let menuItem = MenuItem(icon: item["icon"].stringValue,
                                        id: item["id"].stringValue,
                                        menuName: item["nama_menu"].stringValue)
                menuList.append(menuItem)
            }
            
            self.menuItemSubject.onNext(menuList)
        }, onError: { error in
            self.errorSubject.onNext(error)
        }, onCompleted: {
            print("get main menu completed")
        })
        .disposed(by: bag)
    }
    
    func getListBerita() {
        var url = URLs.listBerita
        
        if let userData = UserDefaultManager.shared.getUserData() {
            let userId = userData.value?.id_employee

            url = url.replacingOccurrences(of: Constants.VariableKeys.userId.rawValue, with: userId ?? "")
        }
        
        let obs: Observable<[News]> = NetworkManager.shared.APIRequest(.get, url: url)
        
        obs.subscribe(onNext: { data in
            self.beritaListSubject.onNext(data)
        }, onError: { error in
            self.errorSubject.onNext(error)
        }, onCompleted: {
            print("get list berita completed")
        })
        .disposed(by: bag)
    }
}
