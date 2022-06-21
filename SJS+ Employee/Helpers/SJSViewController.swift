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
        
        var buttonColor: UIColor = .white
        switch color {
        case .white:
            buttonColor = .white
        case .black:
            buttonColor = .black
        }
        
        navigationItem.backBarButtonItem?.tintColor = buttonColor
    }
}
