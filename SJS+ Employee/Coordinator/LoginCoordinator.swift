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
        let vc = OnboardingViewController.instantiate(.onboarding)
        vc.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToSignUp() {
        let vc = AuthenticationSignInViewController.instantiate(.login)
        vc.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToRegister() {
        let vc = AuthenticationRegistrationViewController.instantiate(.login)
        vc.coordinator = self
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToOTP() {
        let vc = AuthenticationOTPViewController.instantiate(.login)
        vc.coordinator = self
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToForgotPasswordRequest() {
        let vc = AuthenticationForgotRequestViewController.instantiate(.login)
        vc.coordinator = self
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToMainTab() {
        let navController = UINavigationController()
        let tabCoordinator = TabCoordinator(navigationController: navController)
        tabCoordinator.start()
        
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            window.rootViewController = navController
        }
    }
    
    func backToLogin() {
        for vc in navigationController.viewControllers {
            if vc is AuthenticationSignInViewController {
                navigationController.popToViewController(vc, animated: true)
            }
        }
    }
}
