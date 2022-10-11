//
//  ValidasiDataDescViewController.swift
//  SJS+ Employee
//
//  Created by Yudha on 11/10/22.
//

import UIKit

class ValidasiDataDescViewController: SJSViewController, Storyboarded {

    @IBOutlet weak var closeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
