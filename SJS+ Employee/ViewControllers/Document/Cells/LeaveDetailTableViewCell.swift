//
//  LeaveDetailTableViewCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 12/05/22.
//

import UIKit

class LeaveDetailTableViewCell: UITableViewCell {
    static let identifier = String(describing: LeaveDetailTableViewCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(statusState: StatusPengajuan = .undefined, index: Int) {
        switch index {
        case 0:
            titleLabel.text = "Status"
            if statusState != .undefined {
                switch statusState {
                case .approved:
                    descriptionLabel.text = "Disetujui"
                    descriptionLabel.textColor = UIColor(hexaRGB: "#18DE20")
                case .waiting:
                    descriptionLabel.text = "Menunggu Persetujuan"
                    descriptionLabel.textColor = UIColor(hexaRGB: "#FCAE4F")
                case .rejected:
                    descriptionLabel.text = "Ditolak"
                    descriptionLabel.textColor = UIColor(hexaRGB: "#E03F3F")
                case .undefined:
                    break
                }
            }
            
        case 1:
            titleLabel.text = "Jenis Pengajuan"
            
        case 2:
            titleLabel.text = "Tanggal Pengajuan"
            
        case 3:
            titleLabel.text = "Tanggal Izin Tinggal"
            
        case 4:
            titleLabel.text = "Keterangan"
            
        case 5:
            titleLabel.text = "Alasan Penolakan"
            
        default:
            break
        }
        
    }
}
