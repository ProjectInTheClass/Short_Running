//
//  RecordViewController.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/20.
//

import UIKit
import CoreLocation

class RecordViewController: UIViewController  {

    @IBOutlet weak var goalMeterTextLabel: UILabel!
    @IBOutlet weak var runningDistanceTextLabel: UILabel!
    @IBOutlet weak var textViewForDebug: UITextView!
    
    var prevLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var totalRunningDistance : Double = 0.0
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalMeterTextLabel.text = String((self.parent as! PageViewController).goalRunning)
        // Do any additional setup after loading the view.
        CustomLocationManager.shared.delegate = self
        CustomLocationManager.shared.startTracking()
        
        print(prevLocation)
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func stopButtonTapped(_ sender: Any) {
        CustomLocationManager.shared.stopTracking()
        LocationService.shared.locationDataArray.removeAll()
        self.dismiss(animated: true) {
            self.parent?.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
}
extension RecordViewController: CustomLocationManagerDelegate {
    func customLocationManager(didUpdate locations: [CLLocation]) {
        textViewForDebug.text = LocationService.shared.locationDataArray.description
        
        // 위치가 변할때마다 뛴 거리만큼 더해줌
        let currentLocation : CLLocation
        currentLocation = locations.last!
        print(currentLocation)
        
        if LocationService.shared.locationDataArray.count > 1 {
            print("위치 배열이 1보다 큼")
            let prevLocation = LocationService.shared.locationDataArray.last!
            totalRunningDistance += (prevLocation.distance(from: currentLocation) / 1000)
            print(totalRunningDistance)
            runningDistanceTextLabel.text = String(format: "%.2f", totalRunningDistance)
        }
        
        // 지도에 그려줄 PolyLine용 위도경도 정보들을 SingleTon LocationService의 locationData에 던져줌
        LocationService.shared.locationDataArray.append(locations.last!)
        
        
    }
    
    
}

