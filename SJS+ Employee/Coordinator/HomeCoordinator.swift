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
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeMainViewController.instantiate(.home)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToAbsenMap() {
        let vc = AbsensiMainViewController.instantiate(.absensi)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToAbsenDetail() {
        let vc = ReportAbsensiViewController.instantiate(.absensi)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
