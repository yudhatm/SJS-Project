//
//  SignInViewModel.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 20/05/22.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

protocol SignInViewModelType {
    var loginObs: Observable<User> { get }
    var errorObs: Observable<Error> { get }
    
    func loginUser(username: String, password: String)
}

final class SignInViewModel: SignInViewModelType {
    lazy var loginObs: Observable<User> = self.loginSubject.asObservable()
    lazy var errorObs: Observable<Error> = self.errorSubject.asObservable()
    
    var loginSubject = PublishSubject<User>()
    var errorSubject = PublishSubject<Error>()
    
    private var bag = DisposeBag()
    
    func loginUser(username: String, password: String) {
        let url = URLs.loginURL
        
        let param = ["nik": username, "password": password]
        let obs: Observable<User> = NetworkManager.shared.APIRequest(.post, encoding: JSONEncoding.default, url: url, parameters: param)
            
        obs.subscribe(onNext: { data in
            print(data)
            self.loginSubject.onNext(data)
            UserDefaultManager.shared.saveClassObject(data, key: UserDefaultsKey.userData.rawValue)
        }, onError: { error in
            print(error)
            self.errorSubject.onNext(error)
        }, onCompleted: {
            print("post login completed")
        })
        .disposed(by: bag)
    }
}
