//
//  PenggajianCoordinator.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 19/05/22.
//

import Foundation
import UIKit

class PenggajianCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = PenggajianMainViewController.instantiate(.penggajian)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showAlert(_ controller: UIAlertController) {
        navigationController.present(controller, animated: true, completion: nil)
    }
    
    func goToSlipGajiView() {
        let vc = SlipGajiViewController.instantiate(.penggajian)
        vc.coordinator = self
        vc.viewModel = PenggajianViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
