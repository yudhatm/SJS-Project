//
//  ProfileCoordinator.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 19/05/22.
//

import Foundation
import UIKit

/// Coordinator for Profile Navigation section
class ProfileCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProfileMainViewController.instantiate(.profile)
        vc.coordinator = self
        vc.viewModel = ProfileMainViewModel()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showAlert(_ controller: UIAlertController) {
        navigationController.present(controller, animated: true, completion: nil)
    }
    
    func goToSurvey() {
        let vc = SurveyViewController.instantiate(.profile)
        vc.coordinator = self
        vc.viewModel = SurveyViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToValidasiDataList() {
        let vc = ValidasiDataViewController.instantiate(.profile)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showValidasiDataDesc() {
        let vc = ValidasiDataDescViewController.instantiate(.profile)
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func goToVerifikasiKTP() {
        let vc = VerifikasiKTPViewController.instantiate(.profile)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToHomeChecking() {
        let vc = HomeCheckingViewController.instantiate(.profile)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToReferenceChecking() {
        let vc = ReferenceCheckingViewController.instantiate(.profile)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
