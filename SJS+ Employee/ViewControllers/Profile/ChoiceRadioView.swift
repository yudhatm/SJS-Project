//
//  ChoiceRadioView.swift
//  SJS+ Employee
//
//  Created by Yudha on 22/09/22.
//

import UIKit
import LTHRadioButton
import PureLayout

protocol ChoiceRadioViewDelegate {
    func radioButtonSelected(tag: Int)
    func radioButtonDeselected(tag: Int)
}

class ChoiceRadioView: UIView {

    @IBOutlet weak var radioContainer: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
    var delegate: ChoiceRadioViewDelegate?
    var radioButton: LTHRadioButton!
    
    func setupRadioButton() {
        radioButton = LTHRadioButton(diameter: 30, selectedColor: UIColor.appColor(.sjsOrange), deselectedColor: .gray)
        radioContainer.addSubview(radioButton)
        
        radioButton.configureForAutoLayout()
        radioContainer.configureForAutoLayout()
        
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.autoPinEdgesToSuperviewEdges()
        
        radioButton.onSelect {
            self.delegate?.radioButtonSelected(tag: self.radioButton.tag)
        }

        radioButton.onDeselect {
            self.delegate?.radioButtonDeselected(tag: self.radioButton.tag)
        }
    }
}
