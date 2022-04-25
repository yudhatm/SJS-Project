//
//  Storyboarded.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 22/04/22.
//

import UIKit

//Collection of our storyboard
enum Storyboards: String {
    case login = "Login"
    case onboarding = "Onboarding"
    case home = "Home"
}

protocol Storyboarded {
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
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
