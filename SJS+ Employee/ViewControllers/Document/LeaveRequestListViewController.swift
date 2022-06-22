//
//  LeaveRequestListViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 12/05/22.
//

import UIKit
import DZNEmptyDataSet

class LeaveRequestListViewController: SJSViewController, Storyboarded {
    var coordinator: HomeCoordinator?

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.emptyDataSetSource = self
            tableView.emptyDataSetDelegate = self
            
            tableView.register(UINib(nibName: LeaveRequestListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: LeaveRequestListTableViewCell.identifier)
        }
    }
    
    @IBOutlet weak var createLeaveButton: SJSButton!
    
    var filterList = ["Lihat Semua", "Sakit", "Cuti", "Izin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Daftar Pengajuan"
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter_icon"), style: .plain, target: self, action: #selector(openFilterView))
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc func openFilterView() {
        print("button tapped")
        
        let vc = OverlayBuilder.createOverlayPicker()
        vc.transitioningDelegate = self
        
        vc.titleText = "Jenis Surat"
        vc.pickerComponents = filterList
        vc.buttonCallback = { pickerComponent in
            print(pickerComponent)
        }
        
        self.present(vc, animated: true, completion: nil)
    }
}

extension LeaveRequestListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LeaveRequestListTableViewCell
        
        coordinator?.goToCutiDetail(status: cell.status)
    }
}

extension LeaveRequestListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaveRequestListTableViewCell.identifier, for: indexPath) as! LeaveRequestListTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.setupView(status: .approved)
        case 1:
            cell.setupView(status: .waiting)
        case 2:
            cell.setupView(status: .rejected)
        default:
            break
        }
        
        return cell
    }
}

extension LeaveRequestListViewController: DZNEmptyDataSetDelegate {
    
}

extension LeaveRequestListViewController: DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty_document")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let font = UIFont(name: "Poppins-Medium", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        let string = NSMutableAttributedString(string: "Belum Ada Pengajuan", attributes: [.foregroundColor: UIColor.black, .font: font])
        return string
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let font = UIFont(name: "Poppins-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
        let string = NSMutableAttributedString(string: "Silahkan isi form pengajuan jika kamu tidak dapat hadir ke kantor", attributes: [.foregroundColor: UIColor.black, .font: font])
        return string
    }
}

extension LeaveRequestListViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let overlay = OverlayPickerPresentationController(presentedViewController: presented, presenting: presenting)
        
        return overlay
    }
}
