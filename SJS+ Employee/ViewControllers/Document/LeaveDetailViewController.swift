//
//  LeaveDetailViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 12/05/22.
//

import UIKit

class LeaveDetailViewController: SJSViewController, Storyboarded {
    var coordinator: HomeCoordinator?
    
    @IBOutlet weak var letterImageView: UIImageView!
    @IBOutlet weak var detailTableView: UITableView! {
        didSet {
            detailTableView.delegate = self
            detailTableView.dataSource = self
            
            let nib = UINib(nibName: LeaveDetailTableViewCell.identifier, bundle: nil)
            detailTableView.register(nib, forCellReuseIdentifier: LeaveDetailTableViewCell.identifier)
        }
    }

    var status: StatusPengajuan = .undefined
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension LeaveDetailViewController: UITableViewDelegate {
    
}

extension LeaveDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if status == .rejected {
            return 6
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaveDetailTableViewCell.identifier, for: indexPath) as! LeaveDetailTableViewCell
        
        cell.setupView(statusState: status, index: indexPath.row)
        
        return cell
    }
}
