//
//  WorkplaceListViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 17/05/22.
//

import UIKit
import RxSwift
import ProgressHUD

class WorkplaceListViewController: SJSViewController, Storyboarded {
    weak var coordinator: HomeCoordinator?
    var viewModel: AbsensiViewModelType?
    
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView.register(UINib(nibName: OutletListCell.identifier, bundle: nil), forCellReuseIdentifier: OutletListCell.identifier)
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: searchTextField.frame.height))
            paddingView.backgroundColor = searchTextField.backgroundColor
            searchTextField.leftView = paddingView
            searchTextField.leftViewMode = .always
            searchTextField.layer.borderColor = UIColor(hexaRGB: "AEAEAE")?.cgColor
            searchTextField.attributedPlaceholder = NSMutableAttributedString(string: "Cari Kantor", attributes: [.foregroundColor: UIColor(hexaRGB: "83808B")!])
        }
    }
    
    private var bag = DisposeBag()
    
    var outletList: [OutletData] = []
    var filteredListSubject = PublishSubject<[OutletData]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Pilih Kantor Anda"
        
        setupRx()
        getOutletList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.backButtonColor = .black
    }
    
    func setupRx() {
        viewModel?.outletListObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { list in
                ProgressHUD.dismiss()
                self.outletList = list
                self.filteredListSubject.onNext(list)
            })
            .disposed(by: bag)
        
        searchTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [unowned self] query in
                guard query != "" else {
                    self.filteredListSubject.onNext(outletList)
                    return
                }
                
                let filterList = self.outletList.filter { $0.name!.lowercased().contains(query.lowercased()) }
                
                self.filteredListSubject.onNext(filterList)
            })
            .disposed(by: bag)
        
        filteredListSubject.asObservable().bind(to: listTableView.rx.items(cellIdentifier: OutletListCell.identifier, cellType: OutletListCell.self)) { index, model, cell in
            cell.outletData = model
            cell.configureView()
        }.disposed(by: bag)
        
        listTableView.rx.modelSelected(OutletData.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] model in
                self.viewModel?.lat = Double(model.latitude ?? "0.0") ?? 0.0
                self.viewModel?.lng = Double(model.longitude ?? "0.0") ?? 0.0
                
                self.coordinator?.goToRegularIn(viewModel: viewModel!)
            })
            .disposed(by: bag)
    }
    
    func getOutletList() {
        ProgressHUD.show()
        viewModel?.getOutletList()
    }
}

