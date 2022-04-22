//
//  LoginCoordinator.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 22/04/22.
//

import UIKit

class LoginCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = AuthenticationSignInViewController.instantiate(.login)
        navigationController.pushViewController(vc, animated: false)
    }
}
