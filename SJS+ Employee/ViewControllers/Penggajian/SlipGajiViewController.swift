//
//  SlipGajiViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 12/05/22.
//

import UIKit
import DropDown
import RxSwift
import RxCocoa
import ProgressHUD
import SwiftyJSON

class SlipGajiViewController: SJSViewController, Storyboarded {
    var coordinator: PenggajianCoordinator?
    var viewModel: PenggajianViewModelType?
    
    @IBOutlet weak var bulanTextField: UITextField!
    @IBOutlet weak var submitButton: SJSButton!
    @IBOutlet weak var slipGajiImage: UIImageView!
    
    var monthsArray: [String] = []
    let dropdown = DropDown()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = LocalizeEnum.slipGajiTitle.rawValue.localized()
        setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        submitButton.setTitle(LocalizeEnum.unduhSlip.rawValue.localized(), for: .normal)
        
        monthsArray = SJSDateFormatter.shared.createSlipGajiMonths()
        
        let currentMonthStr = SJSDateFormatter.shared.createMonthYearString(date: Date())
        print(currentMonthStr)
        
        for item in monthsArray {
            if item == currentMonthStr {
                bulanTextField.text = item
            }
        }
        
        bulanTextField.delegate = self
        
        dropdown.anchorView = bulanTextField
        dropdown.dataSource = monthsArray

        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            bulanTextField.text = item
            
            //TODO: Hit Get SlipGaji API
            viewModel?.getSlipGaji(item)
        }
        
        viewModel?.getSlipGaji(bulanTextField.text ?? "Januari 1970")
    }
    
    func setupRx() {
        viewModel?.slipGajiData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                
            })
            .disposed(by: bag)
        
        self.viewModel?.errorObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                ProgressHUD.dismiss()
                let error = error as NSError
                guard let errorData = error.userInfo["data"] as? JSON else {
                    let errorAc = OverlayBuilder.createErrorAlert(message: error.localizedDescription)
                    self.coordinator?.showAlert(errorAc)
                    return
                }
                
                let message = errorData["message"].stringValue
                let errorAc = OverlayBuilder.createErrorAlert(message: message)
                self.coordinator?.showAlert(errorAc)
            })
            .disposed(by: bag)
    }
}

extension SlipGajiViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropdown.show()
        textField.resignFirstResponder()
        return false
    }
}
