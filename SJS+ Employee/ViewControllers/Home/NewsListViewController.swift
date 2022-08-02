//
//  NewsListViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 06/05/22.
//

import UIKit

class NewsListViewController: SJSViewController, Storyboarded {
    var coordinator: NewsCoordinator?
    
    var viewModel: NewsViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Berita"
    }
}
