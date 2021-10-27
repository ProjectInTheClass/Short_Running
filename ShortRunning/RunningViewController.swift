//
//  RunningViewController.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/20.
//

import UIKit
import GoogleMaps
import CoreLocation

class RunningViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        CustomLocationManager.shared.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: (LocationService.shared.locationDataArray.first!["lat"])!, longitude: (LocationService.shared.locationDataArray.first!["lon"])!, zoom: 16.0)
        mapView.camera = camera
        mapView.animate(to: camera)
    }
    
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            mapView.settings.myLocationButton = true
            print("didchange 호출됨")
        }
    
    
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
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

extension RunningViewController: CustomLocationManagerDelegate {
    func customLocationManager(didUpdate locations: [CLLocation]) {
        
    }
    
    
}
