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
    
    let gmsMutablePath = GMSMutablePath()
    var animatedFlag : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.accessibilityElementsHidden = false
        mapView.settings.myLocationButton = true
        CustomLocationManager.shared.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: (LocationService.shared.locationDataArray.last?.coordinate.latitude)!, longitude: (LocationService.shared.locationDataArray.last?.coordinate.longitude)!, zoom: 16.0)
        mapView.camera = camera
        mapView.animate(to: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (LocationService.shared.locationDataArray.last?.coordinate.latitude)!, longitude: (LocationService.shared.locationDataArray.last?.coordinate.longitude)!)
        marker.title = "출발점"
        marker.snippet = "Where you started"
        marker.map = mapView
        
        
    }
    
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        animatedFlag = !animatedFlag
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
        gmsMutablePath.add(locations.last!.coordinate)
        
        let gmsPolyLineAdd = GMSPolyline(path: gmsMutablePath)
        gmsPolyLineAdd.map = mapView
        
        if(animatedFlag) {
            mapView.animate(toLocation: locations.last!.coordinate)
        }
        
    }
    
    
}
