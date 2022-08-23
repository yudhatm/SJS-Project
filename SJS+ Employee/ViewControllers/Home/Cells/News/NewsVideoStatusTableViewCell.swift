//
//  NewsVideoStatusTableViewCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 06/05/22.
//

import UIKit

class NewsVideoStatusTableViewCell: UITableViewCell {
    static let identifier = String(describing: NewsVideoStatusTableViewCell.self)

    @IBOutlet weak var avatarIconView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var playImage: UIImageView!
    
    var item: News! { didSet { configureView() }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureView() {
        usernameLabel.text = item.namaUser ?? ""
        postDateLabel.text = SJSDateFormatter.shared.createNewsDateText(dateString: item.doc)
        postImageView.kf.setImage(with: URL(string: item.imageUrl ?? ""))
        descriptionLabel.text = item.description ?? ""
        likesLabel.text = "\(item.totalLike ?? 0) Suka"
    }
}
