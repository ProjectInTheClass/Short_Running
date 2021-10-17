//
//  MainViewController.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/17.
//

import UIKit
import MapKit

class MainViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var goalText: UILabel!
    
    var goalNumber = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goalText.text = String(goalNumber)
        
        let initialLocation = CLLocation(latitude: 37.498095, longitude: 127.027610)
        
        mapView.centerToLocation(initialLocation)
        
        
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

private extension MKMapView {
    func centerToLocation(_ location: CLLocation,
                          regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        setRegion(coordinateRegion, animated: true)
    }
}
