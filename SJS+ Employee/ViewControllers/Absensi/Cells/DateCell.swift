//
//  DateCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 18/05/22.
//

import Foundation
import JTAppleCalendar

/// Cell class for Absensi Calendar
class DateCell: JTAppleCell {
    static let identifier = String(describing: DateCell.self)
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var selectedView: UIView!
}
