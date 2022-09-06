//
//  ReportAbsensiViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 18/05/22.
//

import UIKit
import JTAppleCalendar
import RxSwift
import RxCocoa
import ProgressHUD
import SwiftyJSON

class ReportAbsensiViewController: SJSViewController, Storyboarded {
    weak var coordinator: HomeCoordinator?
    var viewModel: AbsensiViewModelType?
    
    @IBOutlet weak var calendarView: JTAppleCalendarView! {
        didSet {
            calendarView.ibCalendarDelegate = self
            calendarView.ibCalendarDataSource = self
            
            calendarView.register(UINib(nibName: DateCell.identifier, bundle: nil), forCellWithReuseIdentifier: DateCell.identifier)
        }
    }
    
    @IBOutlet weak var statsTableView: UITableView! {
        didSet {
            statsTableView.delegate = self
            statsTableView.dataSource = self
            statsTableView.estimatedRowHeight = 200
            statsTableView.rowHeight = UITableView.automaticDimension
            
            statsTableView.register(UINib(nibName: StatsCell.identifier, bundle: nil), forCellReuseIdentifier: StatsCell.identifier)
        }
    }
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.calendarView.scrollToDate(Date())
        setupView()
        
        viewModel?.getAbsenReport()
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    func setupView() {
        self.title = LocalizeEnum.reportAbsensiTitle.rawValue.localized()
        
        nextButton.addTarget(self, action: #selector(scrollToNextMonth), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(scrollToPrevMonth), for: .touchUpInside)
    }
    
    func setupRx() {
        viewModel?.reportAbsenObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                ProgressHUD.dismiss()
                self.configureView(data: data)
            })
            .disposed(by: bag)
        
        viewModel?.errorObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                ProgressHUD.dismiss()
                let errorAc = OverlayBuilder.createErrorAlert(message: error.localizedDescription)
                self.coordinator?.showAlert(errorAc)
            })
            .disposed(by: bag)
    }
    
    func configureView(data: JSON) {
        //TODO: Populate data to calendar and others
    }
    
    @objc func scrollToNextMonth() {
        self.calendarView.scrollToSegment(.next)
    }
    
    @objc func scrollToPrevMonth() {
        self.calendarView.scrollToSegment(.previous)
    }
}

extension ReportAbsensiViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2021 01 01")!
        
        var dateComponent = DateComponents()
        dateComponent.month = 1
        
        let currentDate = Date()
        let endDate = Calendar.current.date(byAdding: dateComponent, to: currentDate) ?? Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate, firstDayOfWeek: .monday)
    }
}

extension ReportAbsensiViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: DateCell.identifier, for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        self.configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        print(visibleDates)
        let visibleDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: visibleDates.monthDates.first?.date ?? Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        let date = Calendar.current.date(from: visibleDateComponents)
        let visibleMonth = dateFormatter.string(from: date ?? Date())
        
        self.monthLabel.text = visibleMonth
    }
}

extension ReportAbsensiViewController: UITableViewDelegate {
    
}

extension ReportAbsensiViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatsCell.identifier, for: indexPath) as! StatsCell
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = LocalizeEnum.absensiTerlambat.rawValue.localized()
            
        case 1:
            cell.titleLabel.text = LocalizeEnum.totalJamKerja.rawValue.localized()
            
        case 2:
            cell.titleLabel.text = LocalizeEnum.sisaCuti.rawValue.localized()
            
        default:
            break
        }
        
        return cell
    }
}

//MARK: Date Cell configuration
extension ReportAbsensiViewController {
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = .appColor(.sjsOrange)
        } else {
            cell.dateLabel.textColor = .gray
        }
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.backgroundColor = .orange
            cell.selectedView.layer.cornerRadius = 12
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.backgroundColor = .clear
            cell.selectedView.isHidden = true
        }
    }
}
