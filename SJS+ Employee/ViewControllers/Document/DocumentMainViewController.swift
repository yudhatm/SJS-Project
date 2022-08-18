//
//  DocumentMainViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 12/05/22.
//

import UIKit
import DZNEmptyDataSet
import RxSwift
import RxCocoa
import ProgressHUD

class DocumentMainViewController: SJSViewController, Storyboarded {
    var coordinator: HomeCoordinator?
    var viewModel: DocumentViewModelType?
    
    var bag = DisposeBag()
    var documents: [Document] = [] {
        didSet { tableView.reloadData() }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.emptyDataSetSource = self
            tableView.emptyDataSetDelegate = self
            
            let nib = UINib(nibName: DocumentListTableViewCell.identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: DocumentListTableViewCell.identifier)
        }
    }
    
    @IBOutlet weak var createDocumentButton: SJSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Dokumen"
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter_icon"), style: .plain, target: self, action: #selector(openFilterView))
        self.navigationItem.rightBarButtonItem = filterButton
        
        createDocumentButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        
        setupRx()
        
        viewModel?.getDocumentList()
    }
    
    func setupRx() {
        viewModel?.documentList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                self.documents = data
            })
            .disposed(by: bag)
        
        self.viewModel?.errorObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                ProgressHUD.dismiss()
                let errorAc = OverlayBuilder.createErrorAlert(message: error.localizedDescription)
                self.coordinator?.showAlert(errorAc)
            })
            .disposed(by: bag)
    }
    
    @objc func openFilterView() {
        print("button tapped")
        
        let vc = OverlayBuilder.createOverlayPicker()
        vc.transitioningDelegate = self
        
        vc.titleText = "Jenis Surat"
//        vc.pickerComponents = filterList
        vc.buttonCallback = { pickerComponent in
            print(pickerComponent)
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func createButtonTapped() {
        coordinator?.goToDocumentRequest(viewModel: viewModel!)
    }
}

extension DocumentMainViewController: UITableViewDelegate {
    
}

extension DocumentMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DocumentListTableViewCell.identifier, for: indexPath) as! DocumentListTableViewCell
        
        cell.document = documents[indexPath.row]
        cell.setupView()
        
        return cell
    }
}

extension DocumentMainViewController: DZNEmptyDataSetDelegate {
    
}

extension DocumentMainViewController: DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty_document")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let font = UIFont(name: "Poppins-Medium", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        let string = NSMutableAttributedString(string: "Belum Ada Dokumen", attributes: [.foregroundColor: UIColor.black, .font: font])
        return string
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let font = UIFont(name: "Poppins-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
        let string = NSMutableAttributedString(string: "Silahkan isi form pengajuan jika kamu tidak dapat hadir ke kantor", attributes: [.foregroundColor: UIColor.black, .font: font])
        return string
    }
}

extension DocumentMainViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let overlay = OverlayPickerPresentationController(presentedViewController: presented, presenting: presenting)
        
        return overlay
    }
}
