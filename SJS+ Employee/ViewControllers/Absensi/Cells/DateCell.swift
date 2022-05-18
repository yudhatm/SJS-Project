//
//  DateCell.swift
//  SJS+ Employee
//
//  Created by Buana on 18/05/22.
//

import Foundation
import JTAppleCalendar

class DateCell: JTAppleCell {
    static let identifier = String(describing: DateCell.self)
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var selectedView: UIView!
}
