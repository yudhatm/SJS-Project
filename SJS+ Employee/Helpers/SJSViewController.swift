//
//  SJSViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 13/06/22.
//

import Foundation

open class SJSViewController: UIViewController {
    
    ///This variable changes the current VC back button color
    public var backButtonColor: Constants.BackButtonColor = .white {
        didSet {
            setBackButton(color: backButtonColor)
        }
    }
    
    open override func viewDidLoad() {
        setBackButton(color: backButtonColor)
        self.navigationController?.setStatusBar(backgroundColor: .appColor(.sjsOrange))
    }
    
    fileprivate func setBackButton(color: Constants.BackButtonColor) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: emptyString, style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.isTranslucent = false
        
        var buttonColor: UIColor = .white
        switch color {
        case .white:
            buttonColor = .white
            self.navigationController?.navigationBar.backgroundColor = .appColor(.sjsOrange)
            self.navigationController?.navigationBar.barTintColor = .appColor(.sjsOrange)
            self.navigationController?.setStatusBar(backgroundColor: .appColor(.sjsOrange))
        case .black:
            buttonColor = .black
            self.navigationController?.navigationBar.backgroundColor = .white
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.setStatusBar(backgroundColor: .white)
        }
        
        self.navigationItem.backBarButtonItem?.tintColor = buttonColor
        self.navigationController?.navigationBar.tintColor = buttonColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: buttonColor]
    }
    
    fileprivate func setNavigationBarColor(color: Constants.BackButtonColor) {
        
    }
}
