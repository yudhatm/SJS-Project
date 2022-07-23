//
//  LeaveRequestViewModel.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 23/07/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol LeaveRequestViewModelType {
    var leaveRequestList: Observable<[LeaveRequest]> { get }
    var errorObs: Observable<Error> { get }
    
    func getLeaveRequestList()
}

class LeaveRequestViewModel: LeaveRequestViewModelType {
    lazy var leaveRequestList: Observable<[LeaveRequest]> = listSubject.asObservable()
    lazy var errorObs: Observable<Error> = errorSubject.asObservable()
    
    var listSubject = PublishSubject<[LeaveRequest]>()
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
    
    func postLeaveRequest() {
        
    }
}
