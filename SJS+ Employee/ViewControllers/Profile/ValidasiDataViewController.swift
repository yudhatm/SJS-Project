//
//  ValidasiDataViewController.swift
//  SJS+ Employee
//
//  Created by Yudha on 10/10/22.
//

import UIKit

class ValidasiDataViewController: SJSViewController, Storyboarded {
    var coordinator: ProfileCoordinator?

    @IBOutlet weak var verifikasiKTPContainer: UIView!
    @IBOutlet weak var homeCheckingContainer: UIView!
    @IBOutlet weak var refCheckingContainer: UIView!
    
    @IBOutlet weak var verifikasiKTPLabel: UILabel!
    @IBOutlet weak var ktpInProcessLabel: UILabel!
    @IBOutlet weak var verifikasiKTPRightImage: UIImageView!
    
    @IBOutlet weak var homeCheckingLabel: UILabel!
    @IBOutlet weak var homeInProcessLabel: UILabel!
    @IBOutlet weak var homeCheckingRightImage: UIImageView!
    
    @IBOutlet weak var refCheckingLabel: UILabel!
    @IBOutlet weak var refInProcessLabel: UILabel!
    @IBOutlet weak var refCheckingRightImage: UIImageView!
    
    @IBOutlet weak var verifikasiKTPButton: UIButton!
    @IBOutlet weak var homeCheckingButton: UIButton!
    @IBOutlet weak var refCheckingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        let infoButton = UIBarButtonItem(image: ImageAsset.getImage(.infoIcon), style: .plain, target: self, action: #selector(infoButtonTapped))
        self.navigationController?.navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc func infoButtonTapped() {
        //TODO: Open Validasi Data Description View
    }
}
