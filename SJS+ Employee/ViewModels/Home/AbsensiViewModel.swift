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
    
    var lat: Double { get set }
    var lng: Double { get set }
}

final class AbsensiViewModel: AbsensiViewModelType {
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var errorSubject = PublishSubject<Error>()
    
    var lat: Double = 0.0
    var lng: Double = 0.0
}
