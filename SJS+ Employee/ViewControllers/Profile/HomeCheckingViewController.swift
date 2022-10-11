//
//  HomeCheckingViewController.swift
//  SJS+ Employee
//
//  Created by Yudha on 11/10/22.
//

import UIKit
import LTHRadioButton
import GoogleMaps
import GooglePlaces
import DropDown

class HomeCheckingViewController: SJSViewController, Storyboarded {
    var coordinator: ProfileCoordinator?
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var checklistButton: UIButton!
    @IBOutlet weak var officeChoiceTextField: UITextField!
    @IBOutlet weak var radioStackView: UIStackView!
    
    var alamatList = ["Alamat KTP", "Alamat Domisili"]
    var radioButtonList: [LTHRadioButton] = []
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var map: GMSMapView!
    var placesClient: GMSPlacesClient!
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0
    
    let dropdown = DropDown()
    var areaArray = ["Test Area 1", "Test Area 2"]
    
    var isChecklistActive = false {
        didSet {
            checklistButton.tintColor = !isChecklistActive ? UIColor.gray : UIColor.appColor(.sjsOrange)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupMapView()
        setupRadioButtons()
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    func setupView() {
        self.title = LocalizeEnum.homeCheckingTitle.rawValue.localized()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 8.0, width: 24.0, height: 24.0))
        let image = ImageAsset.getImage(.dropdownArrow)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        officeChoiceTextField.rightViewMode = .always
        officeChoiceTextField.rightView = view
        
        officeChoiceTextField.delegate = self
        
        dropdown.anchorView = officeChoiceTextField
        dropdown.dataSource = areaArray

        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            officeChoiceTextField.text = item
        }
        
        checklistButton.tintColor = !isChecklistActive ? UIColor.gray : UIColor.appColor(.sjsOrange)
    }
    
    func setupMapView() {
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        // An array to hold the list of likely places.
        var likelyPlaces: [GMSPlace] = []
        
        // The currently selected place.
        var selectedPlace: GMSPlace?
        
        // A default location to use when location permission is not granted.
        let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
        
        // Create a map.
        var zoomLevel: Float = 0
        
        if #available(iOS 14.0, *) {
            zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        } else {
            // Fallback on earlier versions
            zoomLevel = locationManager.desiredAccuracy == kCLLocationAccuracyBest ? preciseLocationZoomLevel : approximateLocationZoomLevel
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        map = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
        map.settings.myLocationButton = false
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.isMyLocationEnabled = false
        
        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(map)
        map.isHidden = true
    }
    
    func setupRadioButtons() {
        for (index, item) in alamatList.enumerated() {
            let choiceView: ChoiceRadioView = .fromNib()
            radioStackView.addArrangedSubview(choiceView)
            choiceView.setupRadioButton()
            choiceView.questionLabel.text = item
            choiceView.delegate = self
            choiceView.radioButton.tag = index
            radioButtonList.append(choiceView.radioButton)
        }
        
        radioStackView.sizeToFit()
    }
    
    @IBAction func kirimButtonTapped(_ sender: Any) {
    }
    
    @IBAction func checklistButtonTapped(_ sender: Any) {
        isChecklistActive = !isChecklistActive
    }
}

extension HomeCheckingViewController: ChoiceRadioViewDelegate {
    func radioButtonSelected(tag: Int) {
        print(tag)
        for button in radioButtonList {
            if button.tag != tag {
                button.deselect()
            }
        }
    }
    
    func radioButtonDeselected(tag: Int) {
    }
}

extension HomeCheckingViewController: CLLocationManagerDelegate {
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        currentLocation = location
        print("Location: \(location)")
        
        var zoomLevel: Float = 0
        
        if #available(iOS 14.0, *) {
            zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        } else {
            // Fallback on earlier versions
            zoomLevel = locationManager.desiredAccuracy == kCLLocationAccuracyBest ? preciseLocationZoomLevel : approximateLocationZoomLevel
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if map.isHidden {
            map.isHidden = false
            map.camera = camera
        } else {
            map.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Check accuracy authorization
        if #available(iOS 14.0, *) {
            let accuracy = manager.accuracyAuthorization
            
            switch accuracy {
            case .fullAccuracy:
                print("Location accuracy is precise.")
            case .reducedAccuracy:
                print("Location accuracy is not precise.")
            @unknown default:
                fatalError()
            }
        } else {
            // Fallback on earlier versions
            let accuracy = manager.desiredAccuracy
            
            if accuracy == kCLLocationAccuracyBest {
                print("Location accuracy is precise.")
            } else {
                print("Location accuracy is not precise.")
            }
        }
        
        // Handle authorization status
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            self.locationManager.startUpdatingLocation()
        @unknown default:
            fatalError()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

extension HomeCheckingViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropdown.show()
        textField.resignFirstResponder()
        return false
    }
}
