//
//  NewsTextStatusTableViewCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 06/05/22.
//

import UIKit

class NewsTextStatusTableViewCell: UITableViewCell {
    static let identifier = String(describing: NewsTextStatusTableViewCell.self)

    @IBOutlet weak var avatarIconView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var item: News! { didSet { configureView() }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarIconView.layer.cornerRadius = avatarIconView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureView() {
        usernameLabel.text = item.namaUser ?? ""
        postDateLabel.text = SJSDateFormatter.shared.createNewsDateText(dateString: item.doc)
        descriptionLabel.text = item.description ?? ""
        likesLabel.text = "\(item.totalLike ?? 0) Suka"
    }
}
