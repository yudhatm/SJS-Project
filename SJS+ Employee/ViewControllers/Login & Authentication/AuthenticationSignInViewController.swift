//
//  AuthenticationSignInViewController.swift
//  SJS+ Employee
//
//  Created by Rizal Hidayat on 18/04/22.
//

import UIKit
import RxSwift
import ProgressHUD

class AuthenticationSignInViewController: UIViewController, Storyboarded {
    weak var coordinator: LoginCoordinator?
    var viewModel: SignInViewModelType?
    
    @IBOutlet weak var nipTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var loginButton: SJSButton!
    @IBOutlet weak var bigRegisterButton: SJSButton!
    @IBOutlet weak var smallRegisterButton: UIButton!
    
    private var bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButtons()
        setupRx()
    }

    //MARK: - Init View
    private func initButtons() {
        forgotButton.addTarget(self, action: #selector(navigateToRequestPassword), for: .touchUpInside)
        smallRegisterButton.addTarget(self, action: #selector(navigateToRegister), for: .touchUpInside)
        bigRegisterButton.addTarget(self, action: #selector(navigateToRegister), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    //MARK: - Navigation
    @objc private func navigateToRequestPassword(){
        coordinator?.goToForgotPasswordRequest()
    }
    
    @objc private func navigateToRegister() {
        coordinator?.goToRegister()
    }

    @objc private func loginTapped() {
        validateInput()
    }
    
    func setupRx() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.loginObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { userData in
                print(userData)
                ProgressHUD.dismiss()
                self.coordinator?.goToMainTab()
            })
            .disposed(by: bag)
        
        viewModel.errorObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                ProgressHUD.dismiss()
                print(error.localizedDescription)
            })
            .disposed(by: bag)
    }
    
    func validateInput() {
        guard nipTextField.text != "" else {
            let ac = OverlayBuilder.createErrorAlert(message: "NIK tidak boleh kosong")
            coordinator?.showAlert(ac)
            return
        }
        
        guard passwordTextField.text != "" else {
            let ac = OverlayBuilder.createErrorAlert(message: "Password tidak boleh kosong")
            coordinator?.showAlert(ac)
            return
        }
        
        ProgressHUD.show()
        viewModel?.loginUser(username: nipTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}
