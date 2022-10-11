//
//  ReferenceCheckingViewController.swift
//  SJS+ Employee
//
//  Created by Yudha on 11/10/22.
//

import UIKit

class ReferenceCheckingViewController: SJSViewController, Storyboarded {
    var coordinator: ProfileCoordinator?
    
    @IBOutlet weak var perusahaanTerakhirTextField: UITextField!
    @IBOutlet weak var namaAtasanTextField: UITextField!
    @IBOutlet weak var jabatanAtasanTextField: UITextField!
    @IBOutlet weak var noTelponKantorTextField: UITextField!
    @IBOutlet weak var noHpAtasanTextField: UITextField!
    @IBOutlet weak var tanggalBergabungTextField: UITextField!
    @IBOutlet weak var tanggalTerakhirTextField: UITextField!
    @IBOutlet weak var masaKerjaTextField: UITextField!
    
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        let firstView = createCalendarImageView()
        let secondView = createCalendarImageView()
        
        tanggalBergabungTextField.rightViewMode = .always
        tanggalBergabungTextField.rightView = firstView
        
        tanggalTerakhirTextField.rightViewMode = .always
        tanggalTerakhirTextField.rightView = secondView
        
        startDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        startDatePicker.preferredDatePickerStyle = .wheels
        endDatePicker.preferredDatePickerStyle = .wheels
        startDatePicker.addTarget(self, action: #selector(handleStartDatePicker), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(handleEndDatePicker), for: .valueChanged)

        tanggalBergabungTextField.inputView = startDatePicker
        tanggalTerakhirTextField.inputView = endDatePicker
    }
    
    func createCalendarImageView() -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 8.0, width: 24.0, height: 24.0))
        let calendarImage = ImageAsset.getImage(.calendarIcon)
        imageView.image = calendarImage
        imageView.contentMode = .scaleAspectFit

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        return view
    }
    
    func convertStartAndEndDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        return dateFormatter.string(from: date)
    }
    
    @IBAction func kirimButtonTapped(_ sender: Any) {
    }
    
    @objc func handleStartDatePicker(sender: UIDatePicker) {
        tanggalBergabungTextField.text = convertStartAndEndDate(date: sender.date)
    }
    
    @objc func handleEndDatePicker(sender: UIDatePicker) {
        tanggalTerakhirTextField.text = convertStartAndEndDate(date: sender.date)
    }
}
