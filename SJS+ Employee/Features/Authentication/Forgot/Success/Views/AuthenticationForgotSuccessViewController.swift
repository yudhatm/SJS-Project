//
//  AuthenticationForgotSuccessViewController.swift
//  SJS+ Employee
//
//  Created by Rizal Hidayat on 18/04/22.
//

import UIKit

class AuthenticationForgotSuccessViewController: UIViewController {

    @IBOutlet weak var backButton: SJSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButtons()
        // Do any additional setup after loading the view.
    }
    // MARK: - Init View
    private func initButtons(){
        backButton.addTarget(self, action: #selector(navigateToSignIn), for: .touchUpInside)
    }
    
    // MARK: - Navigation
    @objc
    private func navigateToSignIn(){
        navigationController?.popToRootViewController(animated: true)
    }

}
