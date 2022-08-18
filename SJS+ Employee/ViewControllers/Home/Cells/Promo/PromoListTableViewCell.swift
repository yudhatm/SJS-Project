//
//  PromoListTableViewCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 29/04/22.
//

import UIKit

class PromoListTableViewCell: UITableViewCell {
    static let identifier = String(describing: PromoListTableViewCell.self)
    
    @IBOutlet weak var promoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var expiredLabel: UILabel!
    
    var model: Promo? {
        didSet {
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureView() {
        guard let model = model else {
            return
        }
        
        promoImage.layer.cornerRadius = 4

        titleLabel.text = model.title ?? ""
        contentLabel.text = model.deskripsi ?? ""
        promoImage.kf.setImage(with: URL(string: model.image ?? ""))
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        df.timeZone = TimeZone(identifier: "id")
        let date = df.date(from: model.doc ?? "") ?? Date()
        df.dateFormat = "dd MMMM yyyy"
        let string = df.string(from: date)
        
        expiredLabel.text = "Expired: \(string)"
    }
}
