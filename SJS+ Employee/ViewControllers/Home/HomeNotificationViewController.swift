//
//  HomeNotificationViewController.swift
//  SJS+ Employee
//
//  Created by Yudha on 27/04/22.
//

import UIKit
import DZNEmptyDataSet

class HomeNotificationViewController: UIViewController, Storyboarded {
//    weak var coordinator: HomeCoordinator?
    weak var coordinator: LoginCoordinator?
    
    var notificationFilter = ["Semua", "Absensi", "Pengajuan", "Promo", "Berita", "Dokumen"]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.emptyDataSetSource = self
            tableView.emptyDataSetDelegate = self
            
            tableView.register(UINib(nibName: NotificationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NotificationTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    func setupView() {
        self.title = "Notification"
        let filterButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(openFilterView))
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc func openFilterView() {
        print("button tapped")
        
        let vc = OverlayBuilder.createOverlayPicker()
        vc.transitioningDelegate = self
        
        vc.titleText = "Menu Notifikasi"
        vc.pickerComponents = notificationFilter
        vc.buttonCallback = { pickerComponent in
            print(pickerComponent)
        }
        
        self.present(vc, animated: true, completion: nil)
    }
}

extension HomeNotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HomeDetailNotificationViewController.instantiate(.home)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeNotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as! NotificationTableViewCell
        
        return cell
    }
}

extension HomeNotificationViewController: DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        //TODO: Ganti image placeholder
        return #imageLiteral(resourceName: "thank-you-1")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let string = NSAttributedString(string: "Tidak Ada Notifikasi Tersedia", attributes: [.font: UIFont(name: "Poppins-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16)])
        
        return string
    }
}

extension HomeNotificationViewController: DZNEmptyDataSetDelegate {
    
}

extension HomeNotificationViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let overlay = OverlayPickerPresentationController(presentedViewController: presented, presenting: presenting)
        
        return overlay
    }
}
