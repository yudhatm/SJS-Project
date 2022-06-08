//
//  PenggajianItemCollectionViewCell.swift
//  SJS+ Employee
//
//  Created by Buana on 11/05/22.
//

import UIKit

class PenggajianItemCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: PenggajianItemCollectionViewCell.self)
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
}
