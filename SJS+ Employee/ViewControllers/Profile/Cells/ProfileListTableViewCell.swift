//
//  ProfileListTableViewCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 10/05/22.
//

import UIKit

class ProfileListTableViewCell: UITableViewCell {

    static let identifier = String(describing: ProfileListTableViewCell.self)
    
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: MenuItem! {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        if let url = URL(string: item.icon ?? "") {
            self.menuIcon.kf.setImage(with: url)
        }
        
        self.titleLabel.text = item.menuName ?? ""
    }

}
