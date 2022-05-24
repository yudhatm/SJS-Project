//
//  AppDelegate.swift
//  SJS+ Employee
//
//  Created by Rizal Hidayat on 04/01/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FirebaseCore
import FirebaseAuth
import netfox
import ProgressHUD
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        #if DEBUG
            NFX.sharedInstance().start()
        #endif
        
        let gmapAPIKey = InfoPlistParser.getStringValue(forKey: InfoPlistKeys.gmapAPIKey)
        GMSServices.provideAPIKey(gmapAPIKey)
        GMSPlacesClient.provideAPIKey(gmapAPIKey)
        
        setNavigationConfiguration()
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        //Setup ProgressHUD
        ProgressHUD.colorAnimation = .appColor(.sjsOrange)
        ProgressHUD.animationType = .lineSpinFade
        
        IQKeyboardManager.shared.enable = true
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func setNavigationConfiguration() {
        UINavigationBar.appearance().backgroundColor = UIColor.appColor(.sjsOrange)
        UINavigationBar.appearance().barTintColor = UIColor.appColor(.sjsOrange)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

