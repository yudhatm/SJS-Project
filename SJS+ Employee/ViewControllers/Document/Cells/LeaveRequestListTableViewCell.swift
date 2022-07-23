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
    var leaveRequest: LeaveRequest?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        guard let leaveRequest = leaveRequest else {
            return
        }
        
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: "id")
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let convertedDate = df.date(from: leaveRequest.doc ?? "2000-01-01 10:00:00")
        
        df.dateFormat = "hh MMM yy"
        let dateStr = df.string(from: convertedDate ?? Date())
        
        leaveTypeLabel.text = leaveRequest.message ?? ""
        dateLabel.text = dateStr
        
        statusLabel.text = leaveRequest.status_name ?? "-"
        statusLabel.textColor = UIColor(hexaRGB: leaveRequest.status_name_color ?? "#F3F3F3")
        
//        statusView.backgroundColor = UIColor(hexaRGB: "#F3F3F3", alpha: 0.5)
//        statusView.layer.cornerRadius = statusView.frame.height / 2
//        statusView.layer.borderWidth = 1
    }
}
