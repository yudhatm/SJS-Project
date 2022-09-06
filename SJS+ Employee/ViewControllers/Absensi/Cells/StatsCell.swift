//
//  StatsCell.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 18/05/22.
//

import UIKit

class StatsCell: UITableViewCell {
    static let identifier = String(describing: StatsCell.self)

    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var fillView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var absenMasukLabel: UILabel!
    @IBOutlet weak var nonAbsenLabel: UILabel!
    @IBOutlet weak var totalAbsenLabel: UILabel!
    
    let pieLayer = PieLayer()
    let pieBlueColor = UIColor(hexaRGB: "#5B9BD5")
    let pieOrangeColor = UIColor(hexaRGB: "#ED8138")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupPieChart()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupPieChart() {
        pieChartView.layer.cornerRadius = pieChartView.frame.height / 2
        pieChartView.clipsToBounds = true
        
        fillView.layer.cornerRadius = fillView.frame.height / 2
        
        pieLayer.frame = CGRect(x: 0, y: 0, width: 100.0, height: 100.0)
        self.pieChartView.layer.addSublayer(pieLayer)
        
        pieLayer.addValues([PieElement(value: 5.0, color: pieBlueColor)!,
                            PieElement(value: 4.0, color: pieOrangeColor)!], animated: true)
    }
}
