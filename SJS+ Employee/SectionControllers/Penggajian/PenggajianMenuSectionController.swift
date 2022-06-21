//
//  PenggajianMenuSectionController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 15/06/22.
//

import UIKit
import IGListKit

class PenggajianMenuSectionController: ListSectionController {
    var item: Menu!
    
    override init() {
        super.init()
        
        self.minimumInteritemSpacing = 1
        self.minimumLineSpacing = 1
    }
}

extension PenggajianMenuSectionController {
    override func numberOfItems() -> Int {
        return item.menu?.count ?? 3
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        let itemSize = floor(width / 3)
        
        return CGSize(width: itemSize, height: itemSize)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext!.dequeueReusableCell(withNibName: "PenggajianItemCollectionViewCell", bundle: nil, for: self, at: index) as? PenggajianItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = item.menu?[index]
        cell.menuLabel.text = item?.nama_menu
        
//        let width = collectionContext!.containerSize.width
//        let itemSize = floor(width / 4)
//        cell.containerViewWidth.constant = itemSize
        
        print("cell width")
        print(cell.containerViewWidth.constant)
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.item = object as? Menu
    }
}
