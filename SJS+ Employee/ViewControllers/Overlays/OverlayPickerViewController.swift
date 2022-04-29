//
//  OverlayPickerViewController.swift
//  SJS+ Employee
//
//  Created by Buana on 29/04/22.
//

import Foundation
import UIKit
import PureLayout

class OverlayPickerViewController: UIViewController {
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    var titleText: String = "Placeholder"
    var buttonTitleText: String = "Button Title"
    var buttonCallback: ((String) -> Void)?
    
    var pickerComponents: [String] = ["1", "2", "3"]
    
    var selectedComponent = ""
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Poppins-SemiBold", size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        return view
    }()
    
    let topDarkLine: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 3
        return view
    }()
    
    let pickerView: UIPickerView = {
        let view = UIPickerView(frame: CGRect.zero)
        
        return view
    }()
    
    let button: SJSButton = {
        let view = SJSButton(frame: .zero)
        view.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    func setupViews() {
        containerView.configureForAutoLayout()
        topDarkLine.configureForAutoLayout()
        titleLabel.configureForAutoLayout()
        
        view.addSubview(containerView)
        containerView.autoPinEdgesToSuperviewEdges()
        
        containerView.addSubview(topDarkLine)
        topDarkLine.autoPinEdge(toSuperviewEdge: .top, withInset: Constraints.margin8)
        topDarkLine.autoAlignAxis(toSuperviewAxis: .vertical)
        topDarkLine.autoSetDimension(.height, toSize: 6)
        topDarkLine.autoSetDimension(.width, toSize: self.view.frame.width * ViewSize.oneQuarterScreen)
        
        containerView.addSubview(titleLabel)
        titleLabel.autoPinEdge(.top, to: .bottom, of: topDarkLine, withOffset: Constraints.margin24)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: Constraints.margin16)
        topDarkLine.autoAlignAxis(toSuperviewAxis: .vertical)
        titleLabel.autoSetDimension(.height, toSize: Constraints.margin16)
        titleLabel.text = titleText
        
        containerView.addSubview(pickerView)
        pickerView.autoPinEdge(toSuperviewEdge: .leading, withInset: Constraints.margin8)
        pickerView.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constraints.margin8)
        pickerView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: Constraints.margin8)
        pickerView.delegate = self
        pickerView.dataSource = self
        
        containerView.addSubview(button)
        button.autoPinEdge(toSuperviewMargin: .leading, withInset: Constraints.margin8)
        button.autoPinEdge(toSuperviewMargin: .trailing, withInset: Constraints.margin8)
        button.autoPinEdge(toSuperviewMargin: .bottom, withInset: Constraints.margin8)
        button.autoPinEdge(.top, to: .bottom, of: pickerView, withOffset: Constraints.margin8)
        button.autoSetDimension(.height, toSize: 50)
        button.cornerRadius = CornerRadius.radius8
        button.color = UIColor.appColor(.sjsOrange)
        button.titleColor = .white
        button.title = "Terapkan"
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        self.buttonCallback?(selectedComponent)
        self.dismiss(animated: true, completion: nil)
    }
}

extension OverlayPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerComponents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerComponents[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedComponent = pickerComponents[row]
    }
}
