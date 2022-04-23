//
//  OnboardingCollectionViewCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 23/04/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var onboardingImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        onboardingImage.image = slide.image
        headerLabel.text = slide.title
        descLabel.text = slide.description
    }
}
