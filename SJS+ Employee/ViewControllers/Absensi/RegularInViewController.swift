//
//  RegularInViewController.swift
//  SJS+ Employee
//
//  Created by Buana on 17/05/22.
//

import UIKit

class RegularInViewController: UIViewController, Storyboarded {
    weak var coordinator: HomeCoordinator?
    var viewModel: AbsensiViewModelType?
    
    @IBOutlet weak var shiftTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var cameraImage: UIImageView!
    
    @IBOutlet weak var absenButton: SJSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("View model data\n")
        print("lat: \(viewModel?.lat)")
        print("lng: \(viewModel?.lng)")
    }
}
