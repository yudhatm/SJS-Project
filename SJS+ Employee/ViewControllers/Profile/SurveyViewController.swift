//
//  SurveyViewController.swift
//  SJS+ Employee
//
//  Created by Yudha on 08/09/22.
//

import UIKit
import RxSwift
import ProgressHUD

class SurveyViewController: SJSViewController, Storyboarded {
    var coordinator: ProfileCoordinator?
    var viewModel: SurveyViewModelType?
    
    @IBOutlet weak var surveyStepLabel: UILabel!
    @IBOutlet weak var surveyCounterLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 200
            tableView.rowHeight = UITableView.automaticDimension
            tableView.isScrollEnabled = false
            
            let surveyCell = UINib(nibName: SurveyCell.identifier, bundle: nil)
            tableView.register(surveyCell, forCellReuseIdentifier: SurveyCell.identifier)
        }
    }
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nextButton: SJSButton!
    @IBOutlet weak var previousButton: SJSButton!
    
    var bag = DisposeBag()
    var currentPage = 1
    
    var surveyQuestions: [SurveyQuestion] = [] {
        didSet {
            tableView.reloadData()
            self.adjustViewsHeight()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.adjustViewsHeight()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupRx()
        viewModel?.getSurveyData(page: currentPage)
    }
    
    override func viewDidLayoutSubviews() {
        adjustViewsHeight()
    }
    
    func setupView() {
        self.title = LocalizeEnum.surveyTitle.rawValue.localized()
    }
    
    func adjustViewsHeight() {
        let height = tableView.contentSize.height
        tableViewHeight.constant = height + 8
        self.view.layoutSubviews()
    }
    
    func setupRx() {
        viewModel?.surveyDataObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                ProgressHUD.dismiss()
                self.surveyQuestions = data.pertanyaan
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
}

extension SurveyViewController: UITableViewDelegate {
    
}

extension SurveyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SurveyCell.identifier, for: indexPath) as! SurveyCell
        
        let list = surveyQuestions[indexPath.row]
        cell.questionLabel.text = "\(indexPath.row + 1). \(list.pertanyaan ?? "")"
        cell.answerList = list.jawaban ?? []
        cell.setupCell()
        
        return cell
    }
}
