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
        let homeCoordinator = HomeCoordinator(navigationController: SJSNavigationController())
        homeCoordinator.start()
        homeCoordinator.navigationController.tabBarItem.title = "Home"
        homeCoordinator.navigationController.tabBarItem.image = UIImage(named: "home")
        
        let penggajianCoordinator = PenggajianCoordinator(navigationController: SJSNavigationController())
        penggajianCoordinator.start()
        penggajianCoordinator.navigationController.tabBarItem.title = "Penggajian"
        penggajianCoordinator.navigationController.tabBarItem.image = UIImage(named: "money")
        
        let newsCoordinator = NewsCoordinator(navigationController: SJSNavigationController())
        newsCoordinator.start()
        newsCoordinator.navigationController.tabBarItem.title = "Berita"
        newsCoordinator.navigationController.tabBarItem.image = UIImage(named: "table")
        
        let profileCoordinator = ProfileCoordinator(navigationController: SJSNavigationController())
        profileCoordinator.start()
        profileCoordinator.navigationController.tabBarItem.title = "Akun"
        profileCoordinator.navigationController.tabBarItem.image = UIImage(named: "user")
        
        self.viewControllers = [homeCoordinator.navigationController,
                                penggajianCoordinator.navigationController,
                                newsCoordinator.navigationController,
                                profileCoordinator.navigationController]
        
        self.tabBar.barTintColor = .white
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .appColor(.sjsOrange)
        self.tabBar.unselectedItemTintColor = UIColor(hexaRGB: "#ADADAD")
    }
}

//MARK: UITabBarDelegate
extension TabMainViewController {
    
}
