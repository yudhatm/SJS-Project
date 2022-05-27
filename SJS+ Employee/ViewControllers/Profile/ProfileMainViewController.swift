//
//  ProfileMainViewController.swift
//  SJS+ Employee
//
//  Created by Buana on 10/05/22.
//

import UIKit
import RxSwift

class ProfileMainViewController: UIViewController, Storyboarded {
    var coordinator: ProfileCoordinator?
    var viewModel: ProfileMainViewModelType?
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.estimatedRowHeight = 100
            listTableView.rowHeight = UITableView.automaticDimension
            listTableView.tableFooterView = UIView()
            
            listTableView.register(UINib(nibName: "ProfileListTableViewCell", bundle: nil), forCellReuseIdentifier: ProfileListTableViewCell.identifier)
        }
    }
    
    @IBOutlet weak var listTableViewHeight: NSLayoutConstraint!
    
    private let bag = DisposeBag()
    
    var menuList: [MenuData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Akun"
        
        setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.getMenuItem()
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func adjustViewsHeight() {
        let height = listTableView.contentSize.height
        listTableViewHeight.constant = height
        self.view.layoutSubviews()
    }
    
    func setupRx() {
        viewModel?.menuObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { list in
                self.menuList = list.menu ?? []
                self.listTableView.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.adjustViewsHeight()
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    self.adjustViewsHeight()
                })
            })
            .disposed(by: bag)
    }
}

extension ProfileMainViewController: UITableViewDelegate {
    
}

extension ProfileMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileListTableViewCell.identifier) as! ProfileListTableViewCell
        
        let item = menuList[indexPath.row]
        
        cell.titleLabel.text = item.nama_menu
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
