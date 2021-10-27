//
//  CustomLocationManager.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/27.
//

import CoreLocation

protocol CustomLocationManagerDelegate: AnyObject {
    func customLocationManager(didUpdate locations: [CLLocation])
}

class CustomLocationManager:NSObject, CLLocationManagerDelegate {
    static let shared = CustomLocationManager()

    // tip: it is better to declare `locationManager` as private, so you can only access it
    // from the manager...
    private var locationManager = CLLocationManager()

    // here is the delegate:
    weak var delegate: CustomLocationManagerDelegate?

    private override init()
    {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func startTracking()
    {
        locationManager.startUpdatingLocation()
    }

    func stopTracking()
    {
        locationManager.stopUpdatingHeading()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // calling the delegate method
        delegate?.customLocationManager(didUpdate: locations)
    }
}
