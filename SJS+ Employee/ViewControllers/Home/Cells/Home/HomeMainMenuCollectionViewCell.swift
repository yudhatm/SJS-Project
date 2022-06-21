//
//  HomeMainMenuCollectionViewCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 25/04/22.
//

import UIKit

class HomeMainMenuCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: HomeMainMenuCollectionViewCell.self)
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var menuImageContainerView: UIView!
    
    override func awakeFromNib() {
        self.menuImageContainerView.layer.cornerRadius = self.menuImageContainerView.frame.height / 2
    }
    
    func setup(_ menuData: MainMenu) {
        self.menuImage.image = menuData.image
        self.menuLabel.text = menuData.title
    }
}
