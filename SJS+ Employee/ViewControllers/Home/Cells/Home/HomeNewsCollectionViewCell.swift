//
//  HomeNewsCollectionViewCell.swift
//  SJS+ Employee
//
//  Created by Yudha on 27/04/22.
//

import UIKit

class HomeNewsCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: HomeNewsCollectionViewCell.self)
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var newsDescLabel: UILabel!
    
    var item: News? {
        didSet {
            guard let item = item else {
                return
            }

            newsImageView.kf.setImage(with: URL(string: item.imageUrl ?? ""))
            avatarImageView.kf.setImage(with: URL(string: item.profileUrl ?? ""), placeholder: UIImage(named: "avatar_placeholder"))
            userNameLabel.text = item.namaUser ?? ""
            newsDescLabel.text = item.description
            
            let df = DateFormatter()
            df.timeZone = TimeZone(identifier: "id")
            df.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let postDate = df.date(from: item.doc ?? "2000-01-01 00:00:00")
            
            let diffComponents = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: postDate ?? Date(), to: Date())
            let seconds = diffComponents.second ?? 0
            let minute = diffComponents.minute ?? 0
            let hour = diffComponents.hour ?? 0
            let day = diffComponents.day ?? 0
            let month = diffComponents.month ?? 0
            let year = diffComponents.year ?? 0
            
            var timeText = ""
            
            if year != 0 {
                timeText = "\(year) tahun yang lalu"
            } else if month != 0 {
                timeText = "\(month) bulan yang lalu"
            } else if day != 0 {
                timeText = "\(day) hari yang lalu"
            } else if hour != 0 {
                timeText = "\(hour) jam yang lalu"
            } else if minute != 0 {
                timeText = "\(minute) menit yang lalu"
            } else {
                timeText = "\(seconds) detik yang lalu"
            }
            
            timeLabel.text = timeText
        }
    }
    
    override func awakeFromNib() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
}
