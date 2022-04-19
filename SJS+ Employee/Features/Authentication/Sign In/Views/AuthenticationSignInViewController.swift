//
//  AuthenticationSignInViewController.swift
//  SJS+ Employee
//
//  Created by Rizal Hidayat on 18/04/22.
//

import UIKit

class AuthenticationSignInViewController: UIViewController {
    @IBOutlet weak var nipTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var loginButton: SJSButton!
    @IBOutlet weak var bigRegisterButton: SJSButton!
    @IBOutlet weak var smallRegisterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initButtons()
    }

    //MARK: - Init View
    private func initNavigationBar(){
        navigationController?.navigationBar.isHidden = true
    }
    
    private func initButtons(){
        forgotButton.addTarget(self, action: #selector(navigateToRequestPassword), for: .touchUpInside)
        smallRegisterButton.addTarget(self, action: #selector(navigateToRegister), for: .touchUpInside)
        bigRegisterButton.addTarget(self, action: #selector(navigateToRegister), for: .touchUpInside)
    }
    
    //MARK: - Navigation
    @objc
    private func navigateToRequestPassword(){
        let requestPasswordViewController = AuthenticationForgotRequestViewController()
        navigationController?.pushViewController(requestPasswordViewController, animated: true)
    }
    
    @objc
    private func navigateToRegister(){
        let registerViewController = AuthenticationRegistrationViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }

}
