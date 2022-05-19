//
//  PenggajianCoordinator.swift
//  SJS+ Employee
//
//  Created by Buana on 19/05/22.
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
}
