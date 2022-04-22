//
//  AuthenticationForgotRequestViewController.swift
//  SJS+ Employee
//
//  Created by Rizal Hidayat on 18/04/22.
//

import UIKit

class AuthenticationForgotRequestViewController: UIViewController, Storyboarded {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButton: SJSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initButtons()
    }

    // MARK: - Init View
    private func initButtons(){
        resetButton.addTarget(self, action: #selector(navigateToSuccessReset), for: .touchUpInside)
    }
    
    // MARK: - Navigation
    @objc
    private func navigateToSuccessReset(){
        let successResetViewController = AuthenticationForgotSuccessViewController()
        navigationController?.pushViewController(successResetViewController, animated: true)
    }
    

}
