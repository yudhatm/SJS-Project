//
//  NewsDetailViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 06/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

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
    var isLikeNews = false {
        didSet {
            likeImageView.image = isLikeNews ? ImageAsset.getImage(.likeFilled) : ImageAsset.getImage(.likeEmpty)
        }
    }
    
    var likeCount = 0 {
        didSet {
            likesLabel.text = "\(likeCount) Suka"
        }
    }
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
    }
    
    func setupRx() {
        viewModel?.likeNewsDetailObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] data in
                ProgressHUD.dismiss()
                self.isLikeNews = !self.isLikeNews
                
                if self.isLikeNews {
                    self.likeCount += 1
                } else {
                    self.likeCount -= 1
                }
            })
            .disposed(by: bag)
        
        viewModel?.errorObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                ProgressHUD.dismiss()
                let errorAc = OverlayBuilder.createErrorAlert(message: error.localizedDescription)
                self.coordinator?.showAlert(errorAc)
            })
            .disposed(by: bag)
    }
    
    func setupView() {
        self.title = "Detail Berita"
        avatarIconView.layer.cornerRadius = avatarIconView.frame.height / 2
        
        likeImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped))
        likeImageView.addGestureRecognizer(tapGesture)
        
        guard let item = item else { return }
        usernameLabel.text = item.namaUser ?? ""
        postDateLabel.text = SJSDateFormatter.shared.createNewsDateText(dateString: item.doc)
        descriptionLabel.text = item.description ?? ""
        
        likeCount = item.totalLike ?? 0
        
        if let imageUrl = item.imageUrl, imageUrl != "" {
            postImageView.kf.setImage(with: URL(string: imageUrl))
        } else {
            postImageView.isHidden = true
        }
        
        if let isLikeNews = item.isLikeNews {
            self.isLikeNews = isLikeNews
        }
        
        likeImageView.image = isLikeNews ? ImageAsset.getImage(.likeFilled) : ImageAsset.getImage(.likeEmpty)
    }
    
    @objc func likeButtonTapped() {
        guard let id = item.id else { return }
        viewModel?.postLikeBeritaDetail(newsId: id, likeStatus: !isLikeNews)
    }
}
