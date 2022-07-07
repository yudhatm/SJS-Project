//
//  ProfileMainViewModel.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 27/05/22.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

protocol ProfileMainViewModelType {
    var menuObs: Observable<[MenuItem]> { get }
    var errorObs: Observable<Error> { get }
    
    func getMenuItem()
}

final class ProfileMainViewModel: ProfileMainViewModelType {
    lazy var menuObs: Observable<[MenuItem]> = menuSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var menuSubject = PublishSubject<[MenuItem]>()
    var errorSubject = PublishSubject<Error>()
    
    private var bag = DisposeBag()

    func getMenuItem() {
        var url = URLs.newProfileMenuUrl
        
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
            
            self.menuSubject.onNext(menuList)
        }, onError: { error in
            self.errorSubject.onNext(error)
        }, onCompleted: {
            print("get main menu completed")
        })
        .disposed(by: bag)
    }
}
