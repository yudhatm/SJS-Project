//
//  HomeMainViewController.swift
//  SJS+ Employee
//
//  Created by Buana on 25/04/22.
//

import UIKit

class HomeMainViewController: UIViewController, Storyboarded {
    weak var coordinator: LoginCoordinator?

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userCompanyLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userJobLabel: UILabel!
    
    @IBOutlet weak var mainMenuCollectionView: UICollectionView! {
        didSet {
            mainMenuCollectionView.delegate = self
            mainMenuCollectionView.dataSource = self
            mainMenuCollectionView.register(UINib(nibName: HomeMainMenuCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeMainMenuCollectionViewCell.identifier)
//            mainMenuCollectionView.translatesAutoresizingMaskIntoConstraints = false
//            mainMenuCollectionView.invalidateIntrinsicContentSize()
            
//            let flowLayout = UICollectionViewFlowLayout()
//            mainMenuCollectionView.collectionViewLayout = flowLayout
        }
    }
    
    @IBOutlet weak var mainMenuCollectionViewHeight: NSLayoutConstraint!
    
    private let sectionInsets = UIEdgeInsets(
        top: 8.0,
        left: 8.0,
        bottom: 8.0,
        right: 8.0
    )
    
    var itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let height = mainMenuCollectionView.collectionViewLayout.collectionView?.contentSize.height
        mainMenuCollectionViewHeight.constant = height ?? 0

        self.view.layoutIfNeeded()
    }
}

extension HomeMainViewController: UICollectionViewDelegate {
    
}

extension HomeMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainMenuCollectionView {
            return 6
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainMenuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainMenuCollectionViewCell.identifier, for: indexPath) as! HomeMainMenuCollectionViewCell
            
            let menu = MainMenu(image: #imageLiteral(resourceName: "logo-sjs"), title: "menu \(indexPath.row)")
            
            cell.backgroundColor = .red
            cell.setup(menu)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension HomeMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.mainMenuCollectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem * 1.2
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
