//
//  Coordinator.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 22/04/22.
//

import UIKit

/// The base protocol that contains everything needed for Coordinator Pattern
/// For more information on how to use Coordinator Pattern: https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    /// Primary function to show the first view controller that navigation controller hold. Don't forget to instantiate view controller inside start()
    func start()
    /// Helper function to show alert controller with Coordinator
    func showAlert(_ controller: UIAlertController)
}
