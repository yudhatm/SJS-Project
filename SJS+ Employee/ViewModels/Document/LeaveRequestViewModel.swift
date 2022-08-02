//
//  LeaveRequestViewModel.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 23/07/22.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON
import Alamofire

protocol LeaveRequestViewModelType {
    var leaveRequestList: Observable<[LeaveRequest]> { get }
    var submitRequestObs: Observable<JSON> { get }
    var errorObs: Observable<Error> { get }
    
    func getLeaveRequestList()
    func postLeaveRequest(parameters: [String: Any], photoData: Data, imageKeyName: String, imageFileName: String)
}

class LeaveRequestViewModel: LeaveRequestViewModelType {
    lazy var leaveRequestList: Observable<[LeaveRequest]> = listSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    lazy var submitRequestObs: Observable<JSON> = submitRequestSubject.asObservable()
    
    var listSubject = PublishSubject<[LeaveRequest]>()
    var submitRequestSubject = PublishSubject<JSON>()
    var errorSubject = PublishSubject<Error>()
    
    var bag = DisposeBag()
    
    func getLeaveRequestList() {
        if let userData = UserDefaultManager.shared.getUserData() {
            let userId = userData.value?.id_employee ?? "0"
            
            let url = URLs.pengajuan.replacingOccurrences(of: VariableKeys.userId.rawValue, with: userId)
            let obs: Observable<[LeaveRequest]> = NetworkManager.shared.APIRequest(.get, url: url)
            
            obs.subscribe(onNext: { data in
                print(data)
                self.listSubject.onNext(data)
            }, onError: { error in
                print(error)
                self.errorSubject.onNext(error)
            }, onCompleted: {
                print("get leave request list completed")
            })
            .disposed(by: bag)
        }
    }
    
    func postLeaveRequest(parameters: [String: Any], photoData: Data, imageKeyName: String, imageFileName: String) {
        let url = URLs.insertPengajuan
        let obs: Observable<JSON> = NetworkManager.shared.APIUploadRequest(.post, encoding: JSONEncoding.default, url: url, parameters: parameters, uploadData: photoData, imageName: imageFileName, imageKeyName: imageKeyName)
        
        obs.subscribe(onNext: { data in
            print("absen success")
            print("absen data: \n\(data)")
            self.submitRequestSubject.onNext(data)
        }, onError: { error in
            print("error: \(error.localizedDescription)")
        }, onCompleted: {
            print("post submit request completed")
        })
        .disposed(by: bag)
    }
}
