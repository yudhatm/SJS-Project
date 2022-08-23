//
//  HomeNewsCollectionViewCell.swift
//  SJS+ Employee
//
//  Created by Yudha on 27/04/22.
//

import UIKit

class HomeNewsCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: HomeNewsCollectionViewCell.self)
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var newsDescLabel: UILabel!
    
    var item: News? {
        didSet {
            guard let item = item else {
                return
            }

            newsImageView.kf.setImage(with: URL(string: item.imageUrl ?? ""))
            avatarImageView.kf.setImage(with: URL(string: item.profileUrl ?? ""), placeholder: UIImage(named: "avatar_placeholder"))
            userNameLabel.text = item.namaUser ?? ""
            newsDescLabel.text = item.description
            
            timeLabel.text = SJSDateFormatter.shared.createNewsDateText(dateString: item.doc)
        }
    }
    
    override func awakeFromNib() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
}
