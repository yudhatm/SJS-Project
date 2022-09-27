//
//  SurveyViewModel.swift
//  SJS+ Employee
//
//  Created by Yudha on 27/09/22.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

protocol SurveyViewModelType {
    var surveyDataObs: Observable<SurveyData> { get }
    var errorObs: Observable<Error> { get }
    
    func getSurveyData(page: Int)
}

final class SurveyViewModel: SurveyViewModelType {
    lazy var surveyDataObs: Observable<SurveyData> = surveyDataSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var surveyDataSubject = PublishSubject<SurveyData>()
    var errorSubject = PublishSubject<Error>()
    
    private var bag = DisposeBag()
    
    func getSurveyData(page: Int) {
        let url = URLs.surveyPage.replacingOccurrences(of: VariableKeys.page.rawValue, with: "\(page)")
        
        let obs: Observable<SurveyData> = NetworkManager.shared.APIRequest(.get, url: url)
        
        obs.subscribe(onNext: { data in
            self.surveyDataSubject.onNext(data)
        }, onError: { error in
            self.errorSubject.onNext(error)
        }, onCompleted: {
            print("get survey data page \(page) completed")
        })
        .disposed(by: bag)
    }
}
