//
//  NewsViewModel.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 28/07/22.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

protocol NewsViewModelType {
    var beritaListObs: Observable<[News]> { get }
    var errorObs: Observable<Error> { get }
    
    func getListBerita()
}

final class NewsViewModel: NewsViewModelType {
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    lazy var beritaListObs: Observable<[News]> = beritaListSubject.asObservable()
    
    var beritaListSubject = PublishSubject<[News]>()
    var errorSubject = PublishSubject<Error>()
    
    private var bag = DisposeBag()
    
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
