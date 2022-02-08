//
//  ViewController.swift
//  SJS+ Employee
//
//  Created by Rizal Hidayat on 04/01/22.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let authenticationStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInViewController = authenticationStoryboard.instantiateViewController(withIdentifier: "SignInViewController")
        navigationController?.pushViewController(signInViewController, animated: true)
    }


}

