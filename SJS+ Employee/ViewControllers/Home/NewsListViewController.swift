//
//  NewsListViewController.swift
//  SJS+ Employee
//
//  Created by Buana on 06/05/22.
//

import UIKit

class NewsListViewController: UIViewController, Storyboarded {
    var coordinator: NewsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Berita"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
