//
//  MainViewController.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/17.
//

import UIKit


class MainViewController: UIViewController {

//    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var goalText: UILabel!
//    @IBOutlet weak var mapView: GMSMapView!
    
//    var flagForDidChangeCameraPosition = false
    var goalNumber = 10
//    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goalText.text = String(goalNumber)
        
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//        mapView.delegate = self
//        mapView.isMyLocationEnabled = true
        
        
        
        
        
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        if(goalNumber > 0) {
            goalNumber -= 1
            goalText.text = String(goalNumber)
        } else {
            return
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        goalNumber += 1
        goalText.text = String(goalNumber)
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

//private extension MKMapView {
//    func centerToLocation(_ location: CLLocation,
//                          regionRadius: CLLocationDistance = 1000) {
//        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
//
//        setRegion(coordinateRegion, animated: true)
//    }
//}
