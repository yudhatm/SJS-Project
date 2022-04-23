//
//  AuthenticationRegistrationViewController.swift
//  SJS+ Employee
//
//  Created by Rizal Hidayat on 18/04/22.
//

import UIKit

class AuthenticationRegistrationViewController: UIViewController, Storyboarded {

    weak var coordinator: LoginCoordinator?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmationPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: SJSButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initButtons()
    }

    // MARK: - Init View
    private func initButtons(){
        registerButton.addTarget(self, action: #selector(navigateToOTP), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(navigateToSignIn), for: .touchUpInside)
    }
    
    
    // MARK: - Navigation
    @objc
    private func navigateToOTP(){
        coordinator?.goToOTP()
    }
    
    @objc
    private func navigateToSignIn(){
        let signInViewController = AuthenticationSignInViewController()
        navigationController?.pushViewController(signInViewController, animated: true)
    }
    

}
