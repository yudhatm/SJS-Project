//
//  PenggajianMainViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 11/05/22.
//

import UIKit

class PenggajianMainViewController: SJSViewController, Storyboarded {
    var coordinator: PenggajianCoordinator?
    
    @IBOutlet weak var itemsCollectionView: UICollectionView! {
        didSet {
            itemsCollectionView.delegate = self
            itemsCollectionView.dataSource = self
            
            itemsCollectionView.register(UINib(nibName: PenggajianItemCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PenggajianItemCollectionViewCell.identifier)
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical
            
            itemsCollectionView.collectionViewLayout = flowLayout
            itemsCollectionView.backgroundColor = UIColor(hexaRGB: "F9F9F9")
        }
    }
    
    private let sectionInsets = UIEdgeInsets(
        top: 8.0,
        left: 8.0,
        bottom: 8.0,
        right: 8.0
    )
    
    var itemsPerRow: CGFloat = 3
    
    var menuItems = [MainMenu(image: UIImage(named: "salary")!, title: "Slip Gaji")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = LocalizeEnum.penggajianTitle.rawValue.localized()
    }
}

extension PenggajianMainViewController: UICollectionViewDelegate {
    
}

extension PenggajianMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PenggajianItemCollectionViewCell.identifier, for: indexPath) as! PenggajianItemCollectionViewCell
        
        let item = menuItems[indexPath.row]
        cell.menuIcon.image = item.image
        cell.menuLabel.text = item.title
        
        return cell
    }
}

extension PenggajianMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.itemsCollectionView.frame.width - (paddingSpace + 8)
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}
