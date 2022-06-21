//
//  CardSectionController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 14/06/22.
//

import UIKit
import IGListKit

class CardSectionController: ListSectionController {
    var card: Card!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
}

extension CardSectionController {
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        let height = 200.0
        
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "DebitCardCollectionCell", bundle: nil, for: self, at: index) as? DebitCardCollectionCell else {
            return UICollectionViewCell()
        }
        
        if let card = card {
            cell.bankNameLabel.text = card.bankName
            cell.accountNumberLabel.text = card.accountNumber
            cell.ownerNameLabel.text = card.ownerName
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.card = object as? Card
    }
}
