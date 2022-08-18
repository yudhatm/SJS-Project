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
    
    var item: Promo!
    
    func configureCell() {
        titleLabel.text = item.title ?? ""
        contentLabel.text = item.deskripsi ?? ""
        promoImage.kf.setImage(with: URL(string: item.image ?? ""))
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        df.timeZone = TimeZone(identifier: "id")
        let date = df.date(from: item.doc ?? "") ?? Date()
        df.dateFormat = "dd MMMM yyyy"
        let string = df.string(from: date)
        
        expiredLabel.text = "Expired: \(string)"
    }
    
}
