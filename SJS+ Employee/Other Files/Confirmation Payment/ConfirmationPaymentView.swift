////
////  ConfirmationPaymentView.swift
////  kerjaplus
////
////  Created by Fadil Irshad on 18/12/21.
////
//
//import UIKit
//import WebKit
//
//class ConfirmationPaymentView: BaseView, WKNavigationDelegate, WKUIDelegate {
//
//    @IBOutlet weak var backButton: UIButton!
//    @IBOutlet weak var packageName: UILabel!
//    @IBOutlet weak var icPackage: UIImageView!
//    @IBOutlet weak var totalPay: UILabel!
//    @IBOutlet weak var wkWebview: WKWebView!
//
//    var dataSend = PayDataForSend()
//    var invoiceUrl = ""
//
//    convenience init(_ data: PayDataForSend, invoiceURL: String) {
//        self.init()
//        self.dataSend = data
//        self.invoiceUrl = invoiceURL
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
////    lazy var webView: WKWebView = {
////        let wv = WKWebView()
////        wv.uiDelegate = self
////        wv.navigationDelegate = self
////        wv.translatesAutoresizingMaskIntoConstraints = false
////        return wv
////    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupViews()
//
//        let urlString = self.invoiceUrl
//        let request = URLRequest(url:URL(string: urlString)!)
//        self.wkWebview.navigationDelegate = self
//        self.wkWebview.load(request)
//    }
//
//    private func setupViews() {
//        packageName.text = dataSend.packageName
//        icPackage.setImageFromNetwork(url: dataSend.logo)
//        totalPay.text = "Rp. \(dataSend.amount)"
//
//        backButton
//            .rx
//            .tap
//            .bind { [unowned self] in
//                self.view.endEditing(true)
//                self.dismiss(animated: true, completion: nil)
//            }.disposed(by: disposeBag)
//    }
//
//    @IBAction func payButton(_ sender: Any) {
////        let urlString = "https://checkout-staging.xendit.co/web/623bdf2bbf03c366f18fe5f3"
////        let request = URLRequest(url:URL(string: urlString)!)
////        self.webView.navigationDelegate = self
////        self.webView.load(request)
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
////        self.view.addSubview(webView)
////        NSLayoutConstraint.activate([
////            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
////            webView.topAnchor.constraint(equalTo: view.topAnchor),
////            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
////            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
//    }
//}
