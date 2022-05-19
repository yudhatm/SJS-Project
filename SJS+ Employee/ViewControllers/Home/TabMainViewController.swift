//
//  TabMainViewController.swift
//  SJS+ Employee
//
//  Created by Buana on 19/05/22.
//

import UIKit

class TabMainViewController: UITabBarController, Storyboarded {
    weak var coordinator: TabCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTabBar()
    }
    
    func setupTabBar() {
        let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
        homeCoordinator.start()
        homeCoordinator.navigationController.tabBarItem.title = "Home"
        
        let penggajianCoordinator = PenggajianCoordinator(navigationController: UINavigationController())
        penggajianCoordinator.start()
        penggajianCoordinator.navigationController.tabBarItem.title = "Penggajian"
        
        let newsCoordinator = NewsCoordinator(navigationController: UINavigationController())
        newsCoordinator.start()
        newsCoordinator.navigationController.tabBarItem.title = "Berita"
        
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        profileCoordinator.start()
        profileCoordinator.navigationController.tabBarItem.title = "Akun"
        
        self.viewControllers = [homeCoordinator.navigationController,
                                penggajianCoordinator.navigationController,
                                newsCoordinator.navigationController,
                                profileCoordinator.navigationController]
        
        self.tabBar.barTintColor = .white
        self.tabBar.backgroundColor = .white
    }
}

//MARK: UITabBarDelegate
extension TabMainViewController {
    
}
