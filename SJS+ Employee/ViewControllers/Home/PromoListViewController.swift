//
//  PromoListViewController.swift
//  SJS+ Employee
//
//  Created by Buana on 29/04/22.
//

import UIKit

class PromoListViewController: UIViewController, Storyboarded {
    weak var coordinator: LoginCoordinator?

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UINib(nibName: PromoListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PromoListTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        self.title = "Promo"
    }
}

extension PromoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PromoDetailViewController.instantiate(.home)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PromoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PromoListTableViewCell.identifier, for: indexPath) as! PromoListTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
