//
//  PageViewController.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/20.
//

import UIKit
//import CoreLocation

class PageViewController: UIPageViewController {
    
//    let locationManager = CLLocationManager()
//    var currentLocation: CLLocationCoordinate2D!
//
//    var locationData : [String: Double] = [:] as Dictionary
//
//    private func requestAuthorization() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//    }
    
    var goalRunning: Int = 0
    
    lazy var vcArray: [UIViewController] = {
        return [self.vcInstance(name: "RecordVC") as! RecordViewController,
                self.vcInstance(name: "RunningVC") as! RunningViewController ]
    }()
    
    private func vcInstance(name: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
//        requestAuthorization()
        
        print("This is PageViewController : " + String(goalRunning))
        
        if let firstVC = vcArray.first {
            setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }

        // Do any additional setup after loading the view.
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
            
        }
    
    

}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        
        let prevIndex = vcIndex - 1
        
        guard prevIndex >= 0 else { return nil }
        
        guard vcArray.count > prevIndex else { return nil }
        
        return vcArray[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = vcIndex + 1
        
        guard nextIndex < vcArray.count else { return nil }
        
        guard vcArray.count > nextIndex else { return nil }
        
        return vcArray[nextIndex]
                
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = vcArray.firstIndex(of: firstViewController) else { return 0 }
        return firstViewControllerIndex
    }
    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        if manager.authorizationStatus == .authorizedWhenInUse {
////            currentLocation = locationManager!.location?.coordinate
////            LocationService.shared.setLocationData(lan: currentLocation.latitude, lon: currentLocation.longitude)
//        
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let updatedLocation = locations.last
//        locationData.updateValue((updatedLocation?.coordinate.latitude)!, forKey: "lat")
//        locationData.updateValue((updatedLocation?.coordinate.longitude)!, forKey: "lon")
//        LocationService.shared.locationDataArray.append(locationData)
//        print(LocationService.shared.locationDataArray)
//        
//        
//    }
    
    
    

    
}
