//
//  HomeMainViewController.swift
//  SJS+ Employee
//
//  Created by Buana on 25/04/22.
//

import UIKit
import RxSwift
import ProgressHUD
import Kingfisher

class HomeMainViewController: UIViewController, Storyboarded {
    var coordinator: HomeCoordinator?
    var viewModel: HomeViewModelType?

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userCompanyLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userJobLabel: UILabel!
    
    @IBOutlet weak var absensiNotifView: UIView!
    @IBOutlet weak var absensiNotifLabel: UILabel!
    @IBOutlet weak var absensiButton: SJSButton!
    
    @IBOutlet weak var mainMenuCollectionView: UICollectionView! {
        didSet {
            mainMenuCollectionView.delegate = self
            mainMenuCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var contentCollectionView: UICollectionView! {
        didSet {
            contentCollectionView.delegate = self
            contentCollectionView.dataSource = self
            
//            contentCollectionView.backgroundColor = .green
        }
    }
    
    @IBOutlet weak var newsCollectionView: UICollectionView! {
        didSet {
            newsCollectionView.delegate = self
            newsCollectionView.dataSource = self
            
//            newsCollectionView.backgroundColor = .yellow
        }
    }
    
    @IBOutlet weak var promoCollectionView: UICollectionView! {
        didSet {
            promoCollectionView.delegate = self
            promoCollectionView.dataSource = self
            
//            promoCollectionView.backgroundColor = .cyan
        }
    }
    
    @IBOutlet weak var mainMenuCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var newsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var promoCollectionViewHeight: NSLayoutConstraint!
    
    private let sectionInsets = UIEdgeInsets(
        top: 8.0,
        left: 8.0,
        bottom: 8.0,
        right: 8.0
    )
    
    private let contentSectionInsets = UIEdgeInsets(
        top: 0.0,
        left: 0.0,
        bottom: 0.0,
        right: 0.0
    )
    
    var menuItemsPerRow: CGFloat = 3
    var absenItemsPerRow: CGFloat = 2
    
    private var bag = DisposeBag()
    
    var menuList: [MainMenu] = [MainMenu(image: UIImage(named: "calendar")!, title: "Report Absensi"),
                                MainMenu(image: UIImage(named: "to-do-list")!, title: "Pengajuan Sakit/Izin/Cuti"),
                                MainMenu(image: UIImage(named: "fileIcon")!, title: "Permintaan Surat"),
                                MainMenu(image: UIImage(named: "loan")!, title: "Pengambilan Gaji Dimuka"),
                                MainMenu(image: UIImage(named: "training")!, title: "Training"),
                                MainMenu(image: UIImage(named: "credit-card")!, title: "Pembukaan Rek Baru")
                                ]
    var totalNotif = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupRx()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mainMenuCollectionView.reloadData()
        adjustCollectionViewsHeight()
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    func registerCells() {
        mainMenuCollectionView.register(UINib(nibName: HomeMainMenuCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeMainMenuCollectionViewCell.identifier)
        
        contentCollectionView.register(UINib(nibName: HomeContentReuseableHeader.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeContentReuseableHeader.identifier)
        contentCollectionView.register(UINib(nibName: HomeAbsenCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeAbsenCollectionViewCell.identifier)
        
        newsCollectionView.register(UINib(nibName: HomeNewsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeNewsCollectionViewCell.identifier)
        
        promoCollectionView.register(UINib(nibName: HomePromoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomePromoCollectionViewCell.identifier)
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "SJS+"
    }
    
    func setupView() {
        setupNavigationBar()
        
        absensiButton.addTarget(self, action: #selector(absensiButtonTapped), for: .touchUpInside)
        
        if let userData = viewModel?.getUserData() {
            let data = userData.value
            self.userCompanyLabel.text = data?.nama_perusahaan ?? ""
            self.userNameLabel.text = data?.name_employee ?? ""
            self.userJobLabel.text = data?.position ?? ""
        }
    }
    
    @objc private func absensiButtonTapped() {
        coordinator?.goToAbsenMap()
    }
    
    func setupRx() {
//        viewModel?.menuObs
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: {  menuData in
//                ProgressHUD.dismiss()
//                self.totalNotif = menuData.total_notif
//
//                self.mainMenuCollectionView.reloadData()
//                self.adjustCollectionViewsHeight()
//            })
//            .disposed(by: bag)
    }
    
    func adjustCollectionViewsHeight() {
        let height = mainMenuCollectionView.collectionViewLayout.collectionView?.contentSize.height
        let absenHeight = contentCollectionView.collectionViewLayout.collectionView?.contentSize.height
        
        mainMenuCollectionViewHeight.constant = height ?? 0
        contentCollectionViewHeight.constant = absenHeight ?? 0

        self.view.layoutIfNeeded()
    }
}

extension HomeMainViewController: UICollectionViewDelegate {
    
}

extension HomeMainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainMenuCollectionView {
            return menuList.count
        }
        
        if collectionView == contentCollectionView {
            return 2
        }
        
        if collectionView == newsCollectionView {
            return 5
        }
        
        if collectionView == promoCollectionView {
            return 5
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainMenuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainMenuCollectionViewCell.identifier, for: indexPath) as! HomeMainMenuCollectionViewCell
            
            let data = menuList[indexPath.row]
            cell.setup(data)
            
            return cell
        }
        
        if collectionView == contentCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeAbsenCollectionViewCell.identifier, for: indexPath) as! HomeAbsenCollectionViewCell
            
            return cell
        }
        
        if collectionView == newsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeNewsCollectionViewCell.identifier, for: indexPath) as! HomeNewsCollectionViewCell
            
            return cell
        }
        
        if collectionView == promoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePromoCollectionViewCell.identifier, for: indexPath) as! HomePromoCollectionViewCell
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeContentReuseableHeader.identifier, for: indexPath) as? HomeContentReuseableHeader else {
            return UICollectionReusableView()
        }
        
        if collectionView == contentCollectionView {
            header.headerTitleLabel.text = "Absen"
            header.lihatSemuaButton.isHidden = true
            
            return header
        }
        
        return header
    }
}

extension HomeMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainMenuCollectionView {
            let paddingSpace = sectionInsets.left * (menuItemsPerRow + 1)
            let availableWidth = self.mainMenuCollectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / menuItemsPerRow
            let heightPerItem = widthPerItem * 1.5
            
            return CGSize(width: widthPerItem, height: heightPerItem)
        }
        
        if collectionView == contentCollectionView {
            let paddingSpace = 8.0
            let availableWidth = self.contentCollectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / absenItemsPerRow
            let heightPerItem = widthPerItem * 0.5

            return CGSize(width: widthPerItem, height: heightPerItem)
        }
        
        if collectionView == newsCollectionView {
            return CGSize(width: 225, height: 200)
        }
        
        if collectionView == promoCollectionView {
            return CGSize(width: 225, height: 200)
        }
        
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == mainMenuCollectionView {
            return sectionInsets
        } else {
            return contentSectionInsets
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == mainMenuCollectionView {
            return sectionInsets.left
        }
        
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == contentCollectionView {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
        else {
            return CGSize.zero
        }
    }
}
