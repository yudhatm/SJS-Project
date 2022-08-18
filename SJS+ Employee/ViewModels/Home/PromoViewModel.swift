//
//  PromoViewModel.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 18/08/22.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

protocol PromoViewModelType {
    var promoListObs: Observable<[Promo]> { get }
    var errorObs: Observable<Error> { get }
    
    func getPromoList()
}

final class PromoViewModel: PromoViewModelType {
    lazy var promoListObs: Observable<[Promo]> = promoSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var promoSubject = PublishSubject<[Promo]>()
    var errorSubject = PublishSubject<Error>()
    
    private var bag = DisposeBag()
    
    init() {
        getPromoList()
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
