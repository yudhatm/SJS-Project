//
//  OutletListCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 29/06/22.
//

import UIKit

class OutletListCell: UITableViewCell {
    static let identifier = String(describing: OutletListCell.self)

    @IBOutlet weak var outletNameLabel: UILabel!
    
    var outletData: OutletData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureView() {
        outletNameLabel.text = outletData.name
    }
}
