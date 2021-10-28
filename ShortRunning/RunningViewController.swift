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
        mapView.accessibilityElementsHidden = false
        CustomLocationManager.shared.delegate = self
        
        
        let camera = GMSCameraPosition.camera(withLatitude: (LocationService.shared.locationDataArray.first?.coordinate.latitude)!, longitude: (LocationService.shared.locationDataArray.first?.coordinate.longitude)!, zoom: 16.0)
        mapView.camera = camera
        mapView.animate(to: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (LocationService.shared.locationDataArray.first?.coordinate.latitude)!, longitude: (LocationService.shared.locationDataArray.first?.coordinate.longitude)!)
        marker.title = "출발점"
        marker.snippet = "Where you started"
        marker.map = mapView
    }
    
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            mapView.settings.myLocationButton = true
            print("didchange 호출됨")
        }
    
    
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
            return false
        }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let pageViewController = self.parent as! PageViewController
        pageViewController.goToNextPage(index: 0)
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
