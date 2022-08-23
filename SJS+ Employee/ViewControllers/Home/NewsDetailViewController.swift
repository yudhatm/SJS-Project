//
//  NewsDetailViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 06/05/22.
//

import UIKit

class NewsDetailViewController: SJSViewController, Storyboarded {
    var coordinator: NewsCoordinator?
    var viewModel: NewsViewModelType?
    
    @IBOutlet weak var avatarIconView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    var item: News!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.title = "Detail Berita"
        avatarIconView.layer.cornerRadius = avatarIconView.frame.height / 2
        
        guard let item = item else { return }
        usernameLabel.text = item.namaUser ?? ""
        postDateLabel.text = SJSDateFormatter.shared.createNewsDateText(dateString: item.doc)
        descriptionLabel.text = item.description ?? ""
        likesLabel.text = "\(item.totalLike ?? 0) Suka"
        
        if let imageUrl = item.imageUrl, imageUrl != "" {
            postImageView.kf.setImage(with: URL(string: imageUrl))
        } else {
            postImageView.isHidden = true
        }
    }
}
