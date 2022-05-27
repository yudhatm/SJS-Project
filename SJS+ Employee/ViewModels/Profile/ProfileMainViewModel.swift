//
//  ProfileMainViewModel.swift
//  SJS+ Employee
//
//  Created by Buana on 27/05/22.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

protocol ProfileMainViewModelType {
    var menuObs: Observable<Menu> { get }
    var errorObs: Observable<Error> { get }
    
    func getMenuItem()
}

final class ProfileMainViewModel: ProfileMainViewModelType {
    lazy var menuObs: Observable<Menu> = menuSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var menuSubject = PublishSubject<Menu>()
    var errorSubject = PublishSubject<Error>()
    
    private var bag = DisposeBag()

    func getMenuItem() {
        if let userData = UserDefaultManager.shared.getUserData() {
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
}
