//
//  NewsCoordinator.swift
//  SJS+ Employee
//
//  Created by Buana on 19/05/22.
//

import Foundation
import UIKit

class NewsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: SJSNavigationController

    init(navigationController: SJSNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = NewsListViewController.instantiate(.home)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showAlert(_ controller: UIAlertController) {
        navigationController.present(controller, animated: true, completion: nil)
    }
}
