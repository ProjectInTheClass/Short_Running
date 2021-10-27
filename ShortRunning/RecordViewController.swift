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
    @IBOutlet weak var textViewForDebug: UITextView!
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalMeterTextLabel.text = String((self.parent as! PageViewController).goalRunning)
        // Do any additional setup after loading the view.
        CustomLocationManager.shared.delegate = self
        CustomLocationManager.shared.startTracking()
        
       
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
        LocationService.shared.locationDataArray.removeAll()
        self.dismiss(animated: true)
        
    }
    
}
extension RecordViewController: CustomLocationManagerDelegate {
    func customLocationManager(didUpdate locations: [CLLocation]) {
        LocationService.shared.locationData.updateValue((locations.last?.coordinate.latitude)!, forKey: "lat")
        LocationService.shared.locationData.updateValue((locations.last?.coordinate.longitude)!, forKey: "lon")
        LocationService.shared.locationDataArray.append(LocationService.shared.locationData)
        textViewForDebug.text = LocationService.shared.locationDataArray.description
    }
}

