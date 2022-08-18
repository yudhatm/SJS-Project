////
////  MembershipViewModel.swift
////  kerjaplus
////
////  Created by Fadil Irshad on 17/12/21.
////
//
//import Foundation
//import RxSwift
//import RxCocoa
//
//
//class MembershipViewModel: BaseViewModel {
//
//    // Variables
//    private var repository = MembershipRepository()
//    var requestMember = MembershipRequest.shared
//    var membership = BehaviorRelay<[MembershipPackModel]?>(value: [])
//    var payment = BehaviorRelay<PaymentModel?>(value: nil)
//    var payPelamar = BehaviorRelay<PriceModel?>(value: nil)
//    var hotseat = BehaviorRelay<[HotseatModel]?>(value: nil)
//
//    func getMembershipData(_ state: DataLoadState = .newest) {
//        guard Reachability.shared.isConnectedToNetwork == true else {
//            self.error.onNext(ErrorModel(APIClientError.noInternetConnection.localizedDescription))
//            return
//        }
//
//        repository.getMembership(request: self.requestMember)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] model in
//                self.membership.accept(model)
//                self.state.onNext(.finish)
//            },onError: { [unowned self] error in
//                self.state.onNext(.error)
//            }).disposed(by: disposeBag)
//    }
//
//    func doPayment(_ state: DataLoadState = .newest, idJob: String, itemName: String, amount: Int) {
//        guard Reachability.shared.isConnectedToNetwork == true else {
//            self.error.onNext(ErrorModel(APIClientError.noInternetConnection.localizedDescription))
//            return
//        }
//
//        let params: [String: Any] = ["id_user" : AuthManager.shared.user?.pekerja_header?.id ?? "",
//                                     "amount" : amount,
//                                     "name" : AuthManager.shared.user?.pekerja_header?.full_name ?? "",
//                                     "email" : AuthManager.shared.user?.pekerja_header?.email ?? "",
//                                     "phone" : AuthManager.shared.user?.pekerja_header?.phone_number ?? "",
//                                     "item_name" : itemName,
//                                     "item_id": idJob]
//
//        repository.payment(request: self.requestMember, params: params)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] model in
//                self.payment.accept(model)
//                self.state.onNext(.finish)
//            },onError: { [unowned self] error in
//                self.state.onNext(.error)
//            }).disposed(by: disposeBag)
//    }
//
//    func payPelamar(_ state: DataLoadState = .newest) {
//        guard Reachability.shared.isConnectedToNetwork == true else {
//            self.error.onNext(ErrorModel(APIClientError.noInternetConnection.localizedDescription))
//            return
//        }
//
//        repository.getPayPelamar(request: self.requestMember)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] model in
//                self.payPelamar.accept(model)
//                self.state.onNext(.finish)
//            },onError: { [unowned self] error in
//                self.state.onNext(.error)
//            }).disposed(by: disposeBag)
//    }
//
//    func payPelamarLolos(_ state: DataLoadState = .newest) {
//        guard Reachability.shared.isConnectedToNetwork == true else {
//            self.error.onNext(ErrorModel(APIClientError.noInternetConnection.localizedDescription))
//            return
//        }
//
//        repository.getPayPelamarLolos(request: self.requestMember)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] model in
//                self.payPelamar.accept(model)
//                self.state.onNext(.finish)
//            },onError: { [unowned self] error in
//                self.state.onNext(.error)
//            }).disposed(by: disposeBag)
//    }
//
//    func payHotseat(_ state: DataLoadState = .newest) {
//        guard Reachability.shared.isConnectedToNetwork == true else {
//            self.error.onNext(ErrorModel(APIClientError.noInternetConnection.localizedDescription))
//            return
//        }
//
//        repository.getMasterHotSeat(request: self.requestMember)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] model in
//                self.hotseat.accept(model)
//                self.state.onNext(.finish)
//            },onError: { [unowned self] error in
//                self.state.onNext(.error)
//            }).disposed(by: disposeBag)
//    }
//}
