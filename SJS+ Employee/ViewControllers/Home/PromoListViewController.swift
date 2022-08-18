//
//  PromoListViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 29/04/22.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class PromoListViewController: SJSViewController, Storyboarded {
    weak var coordinator: HomeCoordinator?
    var viewModel: PromoViewModelType?

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 200
            tableView.rowHeight = UITableView.automaticDimension
            
            tableView.register(UINib(nibName: PromoListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PromoListTableViewCell.identifier)
        }
    }
    
    var isMyPromo: Bool = false
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupRx()
    }
    
    func setupView() {
        self.title = "Promo"
    }
    
    func setupRx() {
        viewModel?.promoListObs
            .bind(to: tableView.rx.items(cellIdentifier: PromoListTableViewCell.identifier, cellType: PromoListTableViewCell.self)) { index, model, cell in
                cell.model = model
            }.disposed(by: bag)
        
        tableView.rx
            .modelSelected(Promo.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] model in
                self.coordinator?.goToPromoDetail(promoData: model)
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
