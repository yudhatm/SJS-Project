//
//  SurveyCell.swift
//  SJS+ Employee
//
//  Created by Yudha on 08/09/22.
//

import UIKit
import LTHRadioButton

class SurveyCell: UITableViewCell {
    static let identifier = String(describing: SurveyCell.self)
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var answerList: [String] = []
    var radioButtonList: [LTHRadioButton] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell() {
        for (index, item) in answerList.enumerated() {
            let choiceView: ChoiceRadioView = .fromNib()
            stackView.addArrangedSubview(choiceView)
            choiceView.setupRadioButton()
            choiceView.questionLabel.text = item
            choiceView.delegate = self
            choiceView.radioButton.tag = index
            radioButtonList.append(choiceView.radioButton)
        }
    }
}

extension SurveyCell: ChoiceRadioViewDelegate {
    func radioButtonSelected(tag: Int) {
        for button in radioButtonList {
            if button.tag != tag {
                button.deselect()
            }
        }
    }
    
    func radioButtonDeselected(tag: Int) {
    }
}
