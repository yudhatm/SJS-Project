//
//  ViewController.swift
//  SJS+ Employee
//
//  Created by Rizal Hidayat on 04/01/22.
//

import UIKit

class MainViewController: SJSViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let signInViewController = AuthenticationSignInViewController()
        let authenticationRootViewController = UINavigationController(rootViewController: signInViewController)
        authenticationRootViewController.modalTransitionStyle = .crossDissolve
        authenticationRootViewController.modalPresentationStyle = .fullScreen
        present(authenticationRootViewController, animated: true)
    }
}

