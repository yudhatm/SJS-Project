//
//  PromoDetailViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 29/04/22.
//

import UIKit

class PromoDetailViewController: SJSViewController, Storyboarded {
    var coordinator: HomeCoordinator?
    
    @IBOutlet weak var promoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var promoButton: SJSButton!

    var promoData: Promo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.title = "Detail Promo"
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        guard let promoData = promoData else {
            return
        }
        
        promoImage.kf.setImage(with: URL(string: promoData.image ?? ""))
        titleLabel.text = promoData.title ?? ""
        companyLabel.text = promoData.create_by ?? ""
        descriptionTextView.text = promoData.deskripsi
        promoButton.setTitle("Ambil Promo", for: .normal)
    }
}
