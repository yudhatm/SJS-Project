//
//  AbsensiMainViewController.swift
//  SJS+ Employee
//
//  Created by Buana on 17/05/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AbsensiMainViewController: UIViewController, Storyboarded {
    
    weak var coordinator: HomeCoordinator?
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var checkInButton: SJSButton!
    @IBOutlet weak var absenKunjunganButton: SJSButton!
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var map: GMSMapView!
    var placesClient: GMSPlacesClient!
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        setupMapView()
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
        map.settings.myLocationButton = true
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(map)
        map.isHidden = true
    }
}

extension AbsensiMainViewController: CLLocationManagerDelegate {
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
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
        
//        listLikelyPlaces()
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
