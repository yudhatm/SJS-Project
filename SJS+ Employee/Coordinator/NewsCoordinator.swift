//
//  NewsCoordinator.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 19/05/22.
//

import Foundation
import UIKit

/// Coordinator for News Navigation section
class NewsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = NewsListViewController.instantiate(.home)
        vc.coordinator = self
        vc.viewModel = NewsViewModel()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToCreatePost() {
        let vc = CreatePostViewController.instantiate(.home)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToNewsDetail(viewModel: NewsViewModelType, item: News) {
        let vc = NewsDetailViewController.instantiate(.home)
        vc.coordinator = self
        vc.viewModel = viewModel
        vc.item = item
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAlert(_ controller: UIAlertController) {
        navigationController.present(controller, animated: true, completion: nil)
    }
}
