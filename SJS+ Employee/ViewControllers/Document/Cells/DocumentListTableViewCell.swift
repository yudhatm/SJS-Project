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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(status: StatusPengajuan) {
        self.status = status
        
        switch status {
        case .approved:
            statusLabel.text = "Disetujui"
            statusLabel.textColor = UIColor(hexaRGB: "#18DE20")
            statusView.layer.borderColor = UIColor(hexaRGB: "#18DE20")?.cgColor
        case .waiting:
            statusLabel.text = "Menunggu Persetujuan"
            statusLabel.textColor = UIColor(hexaRGB: "#FCAE4F")
            statusView.layer.borderColor = UIColor(hexaRGB: "#FCAE4F")?.cgColor
        case .rejected:
            statusLabel.text = "Ditolak"
            statusLabel.textColor = UIColor(hexaRGB: "#E03F3F")
            statusView.layer.borderColor = UIColor(hexaRGB: "#E03F3F")?.cgColor
        case .undefined:
            break
        }
        
        statusView.backgroundColor = UIColor(hexaRGB: "#F3F3F3", alpha: 0.5)
        statusView.layer.cornerRadius = statusView.frame.height / 2
        statusView.layer.borderWidth = 1
    }
}
