//
//  HomeMainMenuCollectionViewCell.swift
//  SJS+ Employee
//
//  Created by Buana on 25/04/22.
//

import UIKit

class HomeMainMenuCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: HomeMainMenuCollectionViewCell.self)
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    func setup(_ menuData: MainMenu) {
        self.menuImage.image = menuData.image
        self.menuLabel.text = menuData.title
    }
}
