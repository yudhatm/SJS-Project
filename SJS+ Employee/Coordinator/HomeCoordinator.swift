//
//  HomeCoordinator.swift
//  SJS+ Employee
//
//  Created by Buana on 29/04/22.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: SJSNavigationController

    init(navigationController: SJSNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeMainViewController.instantiate(.home)
        vc.coordinator = self
        vc.viewModel = HomeViewModel()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToAbsenMap() {
        let vc = AbsensiMainViewController.instantiate(.absensi)
        vc.coordinator = self
        vc.viewModel = AbsensiViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToAbsenDetail() {
        let vc = ReportAbsensiViewController.instantiate(.absensi)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToRegularIn(viewModel: AbsensiViewModelType) {
        let vc = RegularInViewController.instantiate(.absensi)
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAlert(_ controller: UIAlertController) {
        navigationController.present(controller, animated: true, completion: nil)
    }
}
