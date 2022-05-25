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
    var menuObs: Observable<Menu> { get }
    var errorObs: Observable<Error> { get }
    
    func getMenuItem()
    func getUserData() -> User?
}

final class HomeViewModel: HomeViewModelType {
    lazy var menuObs: Observable<Menu> = menuSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var menuSubject = PublishSubject<Menu>()
    var errorSubject = PublishSubject<Error>()
    
    private var bag = DisposeBag()
    
    init() {
        getMenuItem()
    }
    
    func getMenuItem() {
        if let userData = getUserData() {
            let employeeId = userData.value?.id_employee ?? "0"
            
            let url = URLs.menuURL + employeeId
            let obs: Observable<Menu> = NetworkManager.shared.APIRequest(.get, url: url)
            
            obs.subscribe(onNext: { data in
                print(data)
                self.menuSubject.onNext(data)
            }, onError: { error in
                print(error)
                self.errorSubject.onNext(error)
            }, onCompleted: {
                print("get menu completed")
            })
            .disposed(by: bag)
        }
    }
    
    func getUserData() -> User? {
        let data = UserDefaultManager.shared.loadObject(key: UserDefaultsKey.userData) as! Dictionary<String, Any>
        let json = JSON(data)
        
        if let userData: User? = DecodeHelper().decode(json: json) {
            return userData
        } else {
            return nil
        }
    }
}
