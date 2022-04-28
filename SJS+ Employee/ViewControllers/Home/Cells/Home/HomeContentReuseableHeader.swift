//
//  HomeContentReuseableHeader.swift
//  SJS+ Employee
//
//  Created by Yudha on 27/04/22.
//

import UIKit

class HomeContentReuseableHeader: UICollectionReusableView {
    static let identifier = String(describing: HomeContentReuseableHeader.self)
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var lihatSemuaButton: UIButton!
}
