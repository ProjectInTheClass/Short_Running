//
//  RunningViewController.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/20.
//

import UIKit
import GoogleMaps
import CoreLocation

class RunningViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
    }
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations.last
            let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 16.0)
            mapView.camera = camera
            mapView.animate(to: camera)
    
        }
    
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            mapView.settings.myLocationButton = true
            locationManager.stopUpdatingLocation()
            print("didchange 호출됨")
        }
    
    
    
        func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
            locationManager.startUpdatingLocation()
            return false
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  

}
