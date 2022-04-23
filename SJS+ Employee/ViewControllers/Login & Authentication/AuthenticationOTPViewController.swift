//
//  AuthenticationOTPViewController.swift
//  SJS+ Employee
//
//  Created by Rizal Hidayat on 19/04/22.
//

import UIKit

class AuthenticationOTPViewController: UIViewController, Storyboarded {
    weak var coordinator: LoginCoordinator?
    
    @IBOutlet weak var firstOTPTextField: UITextField!
    @IBOutlet weak var secondOTPTextField: UITextField!
    @IBOutlet weak var thirdOTPTextField: UITextField!
    @IBOutlet weak var fourthOTPTextField: UITextField!
    @IBOutlet weak var fifthOTPTextField: UITextField!
    @IBOutlet weak var sixthOTPTextField: UITextField!
    @IBOutlet weak var backButton: SJSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
    }

    private func initButton(){
        backButton.addTarget(self, action: #selector(navigateToSignIn), for: .touchUpInside)
    }
    
    // MARK: - Navigation
    @objc
    private func navigateToSignIn() {
        coordinator?.backToLogin()
    }

}
