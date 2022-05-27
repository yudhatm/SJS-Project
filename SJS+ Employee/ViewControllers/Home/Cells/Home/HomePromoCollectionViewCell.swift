//
//  HomePromoCollectionViewCell.swift
//  SJS+ Employee
//
//  Created by Yudha on 27/04/22.
//

import UIKit

class HomePromoCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: HomePromoCollectionViewCell.self)
    
    @IBOutlet weak var promoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expiredLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
}
