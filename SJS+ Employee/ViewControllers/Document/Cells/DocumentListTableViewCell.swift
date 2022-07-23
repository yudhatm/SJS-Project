//
//  DocumentListTableViewCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 12/05/22.
//

import UIKit

class DocumentListTableViewCell: UITableViewCell {
    static let identifier = String(describing: DocumentListTableViewCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var status: StatusPengajuan = .undefined
    var document: Document?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        guard let document = document else {
            return
        }

        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: "id")
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let convertedDate = df.date(from: document.create ?? "2000-01-01 10:00:00")

        df.dateFormat = "hh MMM yy"
        let dateStr = df.string(from: convertedDate ?? Date())

        titleLabel.text = document.title ?? ""
        dateLabel.text = dateStr

        statusLabel.text = document.status_name ?? "-"
        statusLabel.textColor = UIColor(hexaRGB: document.status_name_color ?? "#F3F3F3")
        statusView.layer.borderColor = UIColor(hexaRGB: document.status_name_color ?? "#F3F3F3")?.cgColor

        statusView.backgroundColor = UIColor(hexaRGB: "#F3F3F3", alpha: 0.5)
        statusView.layer.cornerRadius = statusView.frame.height / 2
        statusView.layer.borderWidth = 1
    }
}
