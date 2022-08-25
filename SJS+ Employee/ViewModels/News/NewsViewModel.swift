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
import Alamofire

protocol NewsViewModelType {
    var beritaListObs: Observable<[News]> { get }
    var likeObs: Observable<JSON> { get }
    var likeNewsDetailObs: Observable<JSON> { get }
    var errorObs: Observable<Error> { get }
    
    func getListBerita()
    func postLikeBerita(newsId: String, likeStatus: Bool)
    func postLikeBeritaDetail(newsId: String, likeStatus: Bool)
}

final class NewsViewModel: NewsViewModelType {
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    lazy var beritaListObs: Observable<[News]> = beritaListSubject.asObservable()
    lazy var likeObs: Observable<JSON> = likeSubject.asObservable()
    lazy var likeNewsDetailObs: Observable<JSON> = likeNewsDetailSubject.asObservable()
    
    var beritaListSubject = PublishSubject<[News]>()
    var likeSubject = PublishSubject<JSON>()
    var likeNewsDetailSubject = PublishSubject<JSON>()
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
    
    func postLikeBerita(newsId: String, likeStatus: Bool) {
        let url = URLs.likeBerita
        
        var param: [String: Any] = [:]
        
        if let userData = UserDefaultManager.shared.getUserData() {
            let userId = userData.value?.id_employee

            param = ["id_user": userId ?? "", "id_berita": newsId, "like": likeStatus]
        }
        
        let obs: Observable<JSON> = NetworkManager.shared.APIRequestJSON(.post, encoding: JSONEncoding.default, url: url, parameters: param)
        
        obs.subscribe(onNext: { data in
            self.likeSubject.onNext(data)
        }, onError: { error in
            self.errorSubject.onNext(error)
        }, onCompleted: {
            print("post like berita completed")
        })
        .disposed(by: bag)
    }
    
    func postLikeBeritaDetail(newsId: String, likeStatus: Bool) {
        let url = URLs.likeBerita
        
        var param: [String: Any] = [:]
        
        if let userData = UserDefaultManager.shared.getUserData() {
            let userId = userData.value?.id_employee

            param = ["id_user": userId ?? "", "id_berita": newsId, "like": likeStatus]
        }
        
        let obs: Observable<JSON> = NetworkManager.shared.APIRequestJSON(.post, encoding: JSONEncoding.default, url: url, parameters: param)
        
        obs.subscribe(onNext: { data in
            self.likeNewsDetailSubject.onNext(data)
        }, onError: { error in
            self.errorSubject.onNext(error)
        }, onCompleted: {
            print("post like berita completed")
        })
        .disposed(by: bag)
    }
}
