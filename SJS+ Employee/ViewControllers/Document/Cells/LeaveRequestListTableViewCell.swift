//
//  LeaveRequestListTableViewCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 12/05/22.
//

import UIKit

class LeaveRequestListTableViewCell: UITableViewCell {
    static let identifier = String(describing: LeaveRequestListTableViewCell.self)
    
    @IBOutlet weak var leaveTypeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var status: StatusPengajuan = .undefined
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        case .waiting:
            statusLabel.text = "Menunggu Persetujuan"
            statusLabel.textColor = UIColor(hexaRGB: "#FCAE4F")
        case .rejected:
            statusLabel.text = "Ditolak"
            statusLabel.textColor = UIColor(hexaRGB: "#E03F3F")
        case .undefined:
            break
        }
    }
}
