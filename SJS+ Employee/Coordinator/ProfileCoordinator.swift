//
//  ProfileCoordinator.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 19/05/22.
//

import Foundation
import UIKit

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
        navigationController.pushViewController(vc, animated: true)
    }
}
