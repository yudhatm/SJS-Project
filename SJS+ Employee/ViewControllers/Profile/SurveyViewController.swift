//
//  SurveyViewController.swift
//  SJS+ Employee
//
//  Created by Yudha on 08/09/22.
//

import UIKit

class SurveyViewController: SJSViewController, Storyboarded {

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
    
    var answerList = [["1", "2", "3"], ["One", "Two", "Three"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        adjustViewsHeight()
    }
    
    func setupView() {
        self.title = LocalizeEnum.surveyTitle.rawValue.localized()
    }
    
    func adjustViewsHeight() {
        let height = tableView.contentSize.height
        tableViewHeight.constant = height
        self.view.layoutSubviews()
    }
}

extension SurveyViewController: UITableViewDelegate {
    
}

extension SurveyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SurveyCell.identifier, for: indexPath) as! SurveyCell
        
        let list = answerList[indexPath.row]
        cell.answerList = list
        cell.setupCell()
        
        return cell
    }
}
