//
//  DocumentViewModel.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 23/07/22.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

protocol DocumentViewModelType {
    var documentList: Observable<[Document]> { get }
    var errorObs: Observable<Error> { get }
    
    func getDocumentList()
}

final class DocumentViewModel: DocumentViewModelType {
    lazy var documentList: Observable<[Document]> = listSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var listSubject = PublishSubject<[Document]>()
    var errorSubject = PublishSubject<Error>()
    
    var bag = DisposeBag()
    
    func getDocumentList() {
        if let userData = UserDefaultManager.shared.getUserData() {
            let userId = userData.value?.id_employee ?? "0"
            
            let url = URLs.documents.replacingOccurrences(of: VariableKeys.userId.rawValue, with: userId)
            let obs: Observable<[Document]> = NetworkManager.shared.APIRequest(.get, url: url)
            
            obs.subscribe(onNext: { data in
                print(data)
                self.listSubject.onNext(data)
            }, onError: { error in
                print(error)
                self.errorSubject.onNext(error)
            }, onCompleted: {
                print("get document list completed")
            })
            .disposed(by: bag)
        }
    }
}
