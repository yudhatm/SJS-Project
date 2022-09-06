//
//  PenggajianViewModel.swift
//  SJS+ Employee
//
//  Created by Yudha on 06/09/22.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

protocol PenggajianViewModelType {
    var slipGajiData: Observable<JSON> { get }
    var errorObs: Observable<Error> { get }
    
    func getSlipGaji(_ date: String)
}

final class PenggajianViewModel: PenggajianViewModelType {
    lazy var slipGajiData: Observable<JSON> = slipGajiSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var slipGajiSubject = PublishSubject<JSON>()
    var errorSubject = PublishSubject<Error>()
    
    var bag = DisposeBag()
    
    func getSlipGaji(_ date: String) {
        if let userData = UserDefaultManager.shared.getUserData() {
            let userId = userData.value?.id_employee ?? "0"
            
            let convertedDate = SJSDateFormatter.shared.convertMonthYearString(str: date)
            let stringArray = convertedDate.components(separatedBy: " ")
            
            let url = URLs.slipGaji.replacingOccurrences(of: VariableKeys.userId.rawValue, with: userId).replacingOccurrences(of: VariableKeys.month.rawValue, with: stringArray[0]).replacingOccurrences(of: VariableKeys.year.rawValue, with: stringArray[1])
            let obs: Observable<JSON> = NetworkManager.shared.APIRequestJSON(.get, url: url)
            
            obs.subscribe(onNext: { data in
                print(data)
                self.slipGajiSubject.onNext(data)
            }, onError: { error in
                print(error)
                self.errorSubject.onNext(error)
            }, onCompleted: {
                print("get slip gaji completed")
            })
            .disposed(by: bag)
        }
    }
}

