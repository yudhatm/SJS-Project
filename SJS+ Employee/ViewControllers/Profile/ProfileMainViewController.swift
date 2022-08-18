//
//  ProfileMainViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 10/05/22.
//

import UIKit
import RxSwift
import ProgressHUD

class ProfileMainViewController: SJSViewController, Storyboarded {
    var coordinator: ProfileCoordinator?
    var viewModel: ProfileMainViewModelType?
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var totalCutiLabel: UILabel!
    @IBOutlet weak var cutiDipakaiLabel: UILabel!
    @IBOutlet weak var sisaCutiLabel: UILabel!
    
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.estimatedRowHeight = 100
            listTableView.rowHeight = UITableView.automaticDimension
            listTableView.tableFooterView = UIView()
            
            listTableView.register(UINib(nibName: "ProfileListTableViewCell", bundle: nil), forCellReuseIdentifier: ProfileListTableViewCell.identifier)
        }
    }
    
    @IBOutlet weak var dataCollectionView: UICollectionView! {
        didSet {
            dataCollectionView.delegate = self
            dataCollectionView.dataSource = self
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            
            dataCollectionView.collectionViewLayout = flowLayout
            
            let cell = UINib(nibName: "ProfileVerificationCollectionViewCell", bundle: nil)
            dataCollectionView.register(cell, forCellWithReuseIdentifier: ProfileVerificationCollectionViewCell.identifier)
        }
    }
    
    @IBOutlet weak var profileButtonView: UIView!
    @IBOutlet weak var listTableViewHeight: NSLayoutConstraint!
    
    private let bag = DisposeBag()
    
    var menuList: [MenuItem] = []
    var verificationList = ["Verifikasi Data",
                            "Home Check",
                            "Ref Check"
                            ]
    
    private let sectionInsets = UIEdgeInsets(
        top: 8.0,
        left: 0.0,
        bottom: 8.0,
        right: 8.0
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.getMenuItem()
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func setupView() {
        self.navigationItem.title = "Akun"
        profileButtonView.layer.cornerRadius = profileButtonView.frame.height / 2
        
        setupRx()
    }
    
    func adjustViewsHeight() {
        let height = listTableView.contentSize.height
        listTableViewHeight.constant = height
        self.view.layoutSubviews()
    }
    
    func setupRx() {
        viewModel?.menuObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { list in
                ProgressHUD.dismiss()
                self.menuList = list
                self.listTableView.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.adjustViewsHeight()
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    self.adjustViewsHeight()
                })
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
}

extension ProfileMainViewController: UITableViewDelegate {
    
}

extension ProfileMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileListTableViewCell.identifier) as! ProfileListTableViewCell
        
        let item = menuList[indexPath.row]
        cell.setup(item)
        
        return cell
    }
}

extension ProfileMainViewController: UICollectionViewDelegate {
    
}

extension ProfileMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return verificationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileVerificationCollectionViewCell.identifier, for: indexPath) as! ProfileVerificationCollectionViewCell
        
        cell.titleLabel.text = verificationList[indexPath.row]
        
        return cell
    }
}

extension ProfileMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (1 + 1)
        let availableWidth = 220.0 - paddingSpace
        let widthPerItem = availableWidth
        let heightPerItem = 50.0
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.right
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}
