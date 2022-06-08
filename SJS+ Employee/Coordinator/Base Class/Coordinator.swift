//
//  Coordinator.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 22/04/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: SJSNavigationController { get set }

    func start()
    func showAlert(_ controller: UIAlertController)
}
