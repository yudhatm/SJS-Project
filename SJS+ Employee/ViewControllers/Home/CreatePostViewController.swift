//
//  CreatePostViewController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 06/05/22.
//

import UIKit
import RxSwift
import RxCocoa

class CreatePostViewController: SJSViewController, Storyboarded {
    var coordinator: NewsCoordinator?
    var viewModel: NewsViewModelType?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var addVideoButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    let kirimButton = UIBarButtonItem()
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backButtonColor = .black
        setupRx()
        
        self.title = LocalizeEnum.createPostTitle.rawValue.localized()
        
        kirimButton.title = LocalizeEnum.kirim.rawValue.localized()
        kirimButton.tintColor = .appColor(.sjsOrange)
        self.navigationItem.rightBarButtonItem = kirimButton
    }
    
    override func viewDidLayoutSubviews() {
        setupView()
    }
    
    func setupView() {
        textView.delegate = self
        textView.text = LocalizeEnum.statusPlaceholder.rawValue.localized()
        textView.textColor = UIColor.lightGray
        
        if let userData = UserDefaultManager.shared.getUserData() {
            usernameLabel.text = userData.value?.name_employee
        }
    }
    
    func setupRx() {
        kirimButton.rx.tap
            .throttle(.seconds(5), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                //TODO: Do Create Post API Call
            })
            .disposed(by: bag)
    }
}

extension CreatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
                textView.text = nil
                textView.textColor = .black
            }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
                textView.text = LocalizeEnum.statusPlaceholder.rawValue.localized()
                textView.textColor = .lightGray
            }
    }
}
