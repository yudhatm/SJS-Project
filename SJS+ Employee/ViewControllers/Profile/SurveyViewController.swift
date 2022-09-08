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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: SJSButton!
    @IBOutlet weak var previousButton: SJSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        self.title = LocalizeEnum.surveyTitle.rawValue.localized()
    }
}
