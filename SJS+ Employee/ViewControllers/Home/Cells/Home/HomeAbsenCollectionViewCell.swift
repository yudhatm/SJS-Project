//
//  HomeAbsenCollectionViewCell.swift
//  SJS+ Employee
//
//  Created by Yudha on 27/04/22.
//

import UIKit

class HomeAbsenCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: HomeAbsenCollectionViewCell.self)
    
    @IBOutlet weak var absenIcon: UIImageView!
    @IBOutlet weak var absenTimeLabel: UILabel!
    @IBOutlet weak var absenTitleLabel: UILabel!
}
