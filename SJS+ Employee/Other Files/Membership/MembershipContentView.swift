////
////  MembershipContentView.swift
////  kerjaplus
////
////  Created by Fadil Irshad on 17/12/21.
////
//
//import UIKit
//
//enum package {
//    case gold
//    case silver
//    case bronze
//}
//
//class MembershipContentView: BaseView {
//
//    @IBOutlet weak var goldButton: UIButton!
//    @IBOutlet weak var silverButton: UIButton!
//    @IBOutlet weak var bronzeButton: UIButton!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var rangeLabel: UILabel!
//    @IBOutlet weak var backButton: UIButton!
//    @IBOutlet weak var containerViewContent: UIView!
//    @IBOutlet weak var buyButton: UIButton!
//    
//    var viewModel = MembershipViewModel()
//    var dataPack = [MembershipPackModel]()
//    var choosePackage = package.gold
//    var sendData = PayDataForSend()
//    var paymentURL = ""
//    var amountSelect = 0
//    var idSelect = ""
//    var nameItem = ItemName.memberGold
//    
//    convenience init(_ data: [MembershipPackModel]) {
//        self.init()
//        self.dataPack = data
//    }
//    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.isHidden = true
//        self.tabBarController?.tabBar.isHidden = true
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupViews()
//    }
//    
//    private func setupViews() {
//        titleLabel.text = "PAKET GOLD"
//        priceLabel.text = "Rp 400.000"
//        rangeLabel.text = "/6 bln"
//        goldButton.backgroundColor = .clear
//        goldButton.layer.cornerRadius = 5
//        goldButton.layer.borderWidth = 2
//        goldButton.layer.borderColor = UIColor.goldenYellow.cgColor
//        containerViewContent.backgroundColor = self.hexStringToUIColor(hex: "#FFDD2C")
//        sendData.id = ""
//        sendData.email = ""
//        sendData.name = ""
//        sendData.phone = ""
//        let harga = Int(dataPack[0].harga ?? "")
//        sendData.amount = harga ?? 0
//        sendData.item_name = "Member Gold"
//        sendData.description = "Pembelian/Upgrade Member Gold"
//        sendData.logo = dataPack[0].logo ?? ""
//        sendData.packageName = dataPack[0].nama ?? ""
//        amountSelect = harga ?? 0
//        idSelect = dataPack[0].id ?? ""
//        
//        backButton
//            .rx
//            .tap
//            .bind { [unowned self] in
//                self.view.endEditing(true)
//                self.navigationController?.popViewController(animated: true)
//            }.disposed(by: disposeBag)
//        
//        buyButton
//            .rx
//            .tap
//            .bind { [unowned self] in
//                self.view.endEditing(true)
//                if AuthManager.shared.token.isEmpty {
//                    self.present(ConfirmationLoginView(), animated: true, completion: nil)
//                } else {
//                    self.viewModel.doPayment(idJob: idSelect, itemName: nameItem.rawValue, amount: amountSelect)
//                    self.showLoading()
//                }
////                let vc = ConfirmationPaymentView(sendData)
////                self.present(vc, animated: true, completion: nil)
//            }.disposed(by: disposeBag)
//        
//        self.viewModel.payment
//            .subscribe(onNext: { [weak self] data in
//                guard let self = self else { return }
//                self.paymentURL = data?.invoice_url ?? ""
//            }).disposed(by: disposeBag)
//        
//        self.viewModel.state
//            .bind(onNext: { [unowned self] state in
//                switch state {
//                case .loading:
//                    self.showLoading()
//                case .finish:
//                    // go to webview
//                    let vc = ConfirmationPaymentView(PayDataForSend(), invoiceURL: self.paymentURL)
//                    self.present(vc, animated: true, completion: nil)
//                default: break
//                }
//            }).disposed(by: disposeBag)
//    }
//
//    @IBAction func goldButton(_ sender: Any) {
//        titleLabel.text = "PAKET GOLD"
//        priceLabel.text = "Rp 400.000"
//        rangeLabel.text = "/6 bln"
//        goldButton.backgroundColor = .clear
//        goldButton.layer.cornerRadius = 5
//        goldButton.layer.borderWidth = 2
//        goldButton.layer.borderColor = UIColor.goldenYellow.cgColor
//        containerViewContent.backgroundColor = self.hexStringToUIColor(hex: "#FFDD2C")
//        
//        bronzeButton.backgroundColor = .clear
//        bronzeButton.layer.cornerRadius = 0
//        bronzeButton.layer.borderWidth = 0
//        bronzeButton.layer.borderColor = UIColor.clear.cgColor
//        
//        silverButton.backgroundColor = .clear
//        silverButton.layer.cornerRadius = 0
//        silverButton.layer.borderWidth = 0
//        silverButton.layer.borderColor = UIColor.clear.cgColor
//        choosePackage = package.gold
//        let harga = Int(dataPack[0].harga ?? "")
//        sendData.amount = harga ?? 0
//        sendData.item_name = "Member Gold"
//        sendData.description = "Pembelian/Upgrade Member Gold"
//        sendData.logo = dataPack[0].logo ?? ""
//        sendData.packageName = dataPack[0].nama ?? ""
//        amountSelect = harga ?? 0
//        idSelect = dataPack[0].id ?? ""
//        nameItem = .memberGold
//    }
//    
//    @IBAction func silverButton(_ sender: Any) {
//        titleLabel.text = "PAKET SILVER"
//        priceLabel.text = "Rp 250.000"
//        rangeLabel.text = "/3 bln"
//        silverButton.backgroundColor = .clear
//        silverButton.layer.cornerRadius = 5
//        silverButton.layer.borderWidth = 2
//        silverButton.layer.borderColor = UIColor.goldenYellow.cgColor
//        containerViewContent.backgroundColor = self.hexStringToUIColor(hex: "#E1DEE5")
//        
//        bronzeButton.backgroundColor = .clear
//        bronzeButton.layer.cornerRadius = 0
//        bronzeButton.layer.borderWidth = 0
//        bronzeButton.layer.borderColor = UIColor.clear.cgColor
//        
//        goldButton.backgroundColor = .clear
//        goldButton.layer.cornerRadius = 0
//        goldButton.layer.borderWidth = 0
//        goldButton.layer.borderColor = UIColor.clear.cgColor
//        choosePackage = package.silver
//        let harga = Int(dataPack[1].harga ?? "")
//        sendData.amount = harga ?? 0
//        sendData.item_name = "Member Silver"
//        sendData.description = "Pembelian/Upgrade Member Silver"
//        sendData.logo = dataPack[1].logo ?? ""
//        sendData.packageName = dataPack[1].nama ?? ""
//        amountSelect = harga ?? 0
//        idSelect = dataPack[1].id ?? ""
//        nameItem = .memberSilver
//    }
//    
//    @IBAction func bronzeButton(_ sender: Any) {
//        titleLabel.text = "PAKET BRONZE"
//        priceLabel.text = "Rp 100.000"
//        rangeLabel.text = "/ bln"
//        bronzeButton.backgroundColor = .clear
//        bronzeButton.layer.cornerRadius = 5
//        bronzeButton.layer.borderWidth = 2
//        bronzeButton.layer.borderColor = UIColor.goldenYellow.cgColor
//        containerViewContent.backgroundColor = self.hexStringToUIColor(hex: "#EC8E46")
//        
//        silverButton.backgroundColor = .clear
//        silverButton.layer.cornerRadius = 0
//        silverButton.layer.borderWidth = 0
//        silverButton.layer.borderColor = UIColor.clear.cgColor
//        
//        goldButton.backgroundColor = .clear
//        goldButton.layer.cornerRadius = 0
//        goldButton.layer.borderWidth = 0
//        goldButton.layer.borderColor = UIColor.clear.cgColor
//        choosePackage = package.bronze
//        let harga = Int(dataPack[2].harga ?? "")
//        sendData.amount = harga ?? 0
//        sendData.item_name = "Member Bronze"
//        sendData.description = "Pembelian/Upgrade Member Bronze"
//        sendData.logo = dataPack[2].logo ?? ""
//        sendData.packageName = dataPack[2].nama ?? ""
//        amountSelect = harga ?? 0
//        idSelect = dataPack[2].id ?? ""
//        nameItem = .memberBronze
//    }
//}
//
//struct PayDataForSend {
//    var id = ""
//    var amount = 0
//    var description = ""
//    var name = ""
//    var email = ""
//    var phone = ""
//    var item_name = ""
//    var logo = ""
//    var packageName = ""
//    
//    init() {
//        id = ""
//        amount = 0
//        description = ""
//        name = ""
//        email = ""
//        phone = ""
//        item_name = ""
//        logo = ""
//        packageName = ""
//    }
//}
