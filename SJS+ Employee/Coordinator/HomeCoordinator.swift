//
//  HomeCoordinator.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 29/04/22.
//

import Foundation
import UIKit

/// Coordinator for Home Navigation section
class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeMainViewController.instantiate(.home)
        vc.coordinator = self
        vc.viewModel = HomeViewModel()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToAbsenMap(isAlreadyAbsenRegularIn: Bool) {
        let vc = AbsensiMainViewController.instantiate(.absensi)
        vc.coordinator = self
        vc.viewModel = AbsensiViewModel()
        vc.viewModel?.isAlreadyAbsenRegularIn = isAlreadyAbsenRegularIn
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToAbsenDetail() {
        let vc = ReportAbsensiViewController.instantiate(.absensi)
        vc.coordinator = self
        vc.viewModel = AbsensiViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToWorkplaceList(viewModel: AbsensiViewModelType) {
        let vc = WorkplaceListViewController.instantiate(.absensi)
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToRegularIn(viewModel: AbsensiViewModelType) {
        let vc = RegularInViewController.instantiate(.absensi)
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPengajuanCuti() {
        let vc = LeaveRequestListViewController.instantiate(.document)
        vc.coordinator = self
        vc.viewModel = LeaveRequestViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToCutiDetail(status: StatusPengajuan) {
        let vc = LeaveDetailViewController.instantiate(.document)
        vc.coordinator = self
        vc.status = status
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPengajuanForm(viewModel: LeaveRequestViewModelType) {
        let vc = LeaveFormViewController.instantiate(.document)
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToDocumentList() {
        let vc = DocumentMainViewController.instantiate(.document)
        vc.coordinator = self
        vc.viewModel = DocumentViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToDocumentRequest(viewModel: DocumentViewModelType) {
        let vc = DocumentRequestViewController.instantiate(.document)
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPromoList() {
        let vc = PromoListViewController.instantiate(.home)
        vc.coordinator = self
        vc.viewModel = PromoViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPromoDetail(promoData: Promo) {
        let vc = PromoDetailViewController.instantiate(.home)
        vc.coordinator = self
        vc.promoData = promoData
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAlert(_ controller: UIAlertController) {
        navigationController.present(controller, animated: true, completion: nil)
    }
    
    func backToHome() {
        navigationController.popToRootViewController(animated: true)
    }
}
