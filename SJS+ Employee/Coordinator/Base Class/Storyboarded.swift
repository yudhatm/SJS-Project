//
//  Storyboarded.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 22/04/22.
//

import UIKit

///Collection of our storyboard. Don't forget to add new enum case if you make new Storyboard.
enum Storyboards: String {
    case login = "Login"
    case onboarding = "Onboarding"
    case home = "Home"
    case penggajian = "Penggajian"
    case profile = "Profile"
    case document = "Document"
    case absensi = "Absensi"
}

/// This protocol simplifies getting view controllers from Storyboards
protocol Storyboarded {
    /// Instantiate available view controllers from the list of Storyboards
    /// - Parameter storyboard: Accept input from Storyboards enum.
    /// - Returns: The instantiated View Controller
    static func instantiate(_ storyboard: Storyboards) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboard: Storyboards) -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        let vc = storyboard.instantiateViewController(withIdentifier: className) as! Self
        
        return vc
    }
}
