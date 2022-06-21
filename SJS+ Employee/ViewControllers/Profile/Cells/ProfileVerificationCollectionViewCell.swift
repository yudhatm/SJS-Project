//
//  ProfileVerificationCollectionViewCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 10/05/22.
//

import UIKit

class ProfileVerificationCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ProfileVerificationCollectionViewCell.self)
    
    @IBOutlet weak var containerView: UIView! {
        didSet { containerView.layer.cornerRadius = 4 }
    }
    @IBOutlet weak var checklistIcon: UIImageView!
    @IBOutlet weak var cautionIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
}
