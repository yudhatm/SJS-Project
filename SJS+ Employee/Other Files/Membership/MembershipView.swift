////
////  MembershipView.swift
////  kerjaplus
////
////  Created by Fadil Irshad on 17/12/21.
////
//
//import UIKit
//
//class MembershipView: BaseView {
//    
//    @IBOutlet weak var backButton: UIButton!
//    @IBOutlet weak var viewContainerStar: UIView!
//    @IBOutlet weak var nextButton: UIButton!
//    
//    var parentVC: UIViewController = UIViewController()
//    var viewModel = MembershipViewModel()
//    var dataPack = [MembershipPackModel]()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupViews()
//    }
//    
//    func setupViews() {
//        bindViewModel()
//        viewContainerStar.cornerRadius = min(viewContainerStar.frame.width/2, viewContainerStar.frame.height/2)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.isHidden = true
//        self.tabBarController?.tabBar.isHidden = true
//    }
//    
//    private func bindViewModel() {
//        self.viewModel.getMembershipData()
//        
//        self.viewModel.membership
//            .subscribe(onNext: { [weak self] data in
//                guard let self = self else { return }
//                self.dataPack = data ?? []
//            }).disposed(by: disposeBag)
//        
//        backButton
//            .rx
//            .tap
//            .bind { [unowned self] in
//                self.view.endEditing(true)
////                self.dismiss(animated: true, completion: nil)
//                self.navigationController?.popViewController(animated: true)
//            }.disposed(by: disposeBag)
//        
//        nextButton
//            .rx
//            .tap
//            .bind { [unowned self] in
//                
//                let vc = MembershipContentView(self.dataPack)
//                self.navigationController?.pushViewController(vc, animated: true)
//  
//            }.disposed(by: disposeBag)
//    }
//}
