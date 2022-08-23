//
//  NewsListViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 06/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class NewsListViewController: SJSViewController, Storyboarded {
    var coordinator: NewsCoordinator?
    var viewModel: NewsViewModelType?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: NewsImageStatusTableViewCell.identifier, bundle: .main), forCellReuseIdentifier: NewsImageStatusTableViewCell.identifier)
            tableView.register(UINib(nibName: NewsTextStatusTableViewCell.identifier, bundle: .main), forCellReuseIdentifier: NewsTextStatusTableViewCell.identifier)
            tableView.register(UINib(nibName: NewsVideoStatusTableViewCell.identifier, bundle: .main), forCellReuseIdentifier: NewsVideoStatusTableViewCell.identifier)
            
            tableView.estimatedRowHeight = 400
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    @IBOutlet weak var editContainerView: UIView!
    @IBOutlet weak var newPostButton: UIButton!
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Berita"
        setupView()
        setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.getListBerita()
    }
    
    override func viewDidLayoutSubviews() {
//        let shadowLayer = CAShapeLayer()
//        shadowLayer.path = UIBezierPath(roundedRect: editContainerView.bounds, cornerRadius: 12).cgPath
//        shadowLayer.fillColor = UIColor.white.cgColor
//
//        shadowLayer.shadowColor = UIColor.darkGray.cgColor
//        shadowLayer.shadowPath = shadowLayer.path
//        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        shadowLayer.shadowOpacity = 0.8
//        shadowLayer.shadowRadius = 2
//
//        editContainerView.layer.insertSublayer(shadowLayer, at: 1)
        
        editContainerView.layer.masksToBounds = false
        editContainerView.layer.cornerRadius = editContainerView.frame.height / 2
        editContainerView.layer.shadowColor = UIColor.black.cgColor
        editContainerView.layer.shadowPath = UIBezierPath(roundedRect: editContainerView.bounds, cornerRadius: editContainerView.layer.cornerRadius).cgPath
        editContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        editContainerView.layer.shadowOpacity = 0.3
        editContainerView.layer.shadowRadius = 1.0
    }
    
    func setupView() {
        
    }
    
    func setupRx() {
        viewModel?.beritaListObs
            .bind(to: tableView.rx.items) { (tableView, row, item) -> UITableViewCell in
                if let videoUrl = item.videoUrl, videoUrl != "" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsVideoStatusTableViewCell.identifier, for: IndexPath(row: row, section: 0)) as! NewsVideoStatusTableViewCell
                    cell.item = item
                    return cell
                } else if let imageUrl = item.imageUrl, imageUrl != "" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageStatusTableViewCell.identifier, for: IndexPath(row: row, section: 0)) as! NewsImageStatusTableViewCell
                    cell.item = item
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextStatusTableViewCell.identifier, for: IndexPath(row: row, section: 0)) as! NewsTextStatusTableViewCell
                    cell.item = item
                    return cell
                }
                
            }.disposed(by: bag)
        
        tableView.rx.modelSelected(News.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] model in
                guard let viewModel = viewModel else {
                    return
                }

                self.coordinator?.goToNewsDetail(viewModel: viewModel, item: model)
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
