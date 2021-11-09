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
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var runningProgressBar: UIProgressView!
    
    var prevLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var totalRunningDistance : Double = 0.0
    
    var timer: DispatchSourceTimer?
    var totalTime : Double = 0.0
    var stopWatchStatus : StopWatchStatus = .start
    var isPlaying : Bool = true
    var gpxDownloadUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad >>>>> ")
        goalMeterTextLabel.text = String((self.parent as! PageViewController).goalRunning)
        
        CustomLocationManager.shared.delegate = self
        CustomLocationManager.shared.startTracking()
        
        runningProgressBar.progress = 0.0
        
        initTimer()
        changeStopWatchStatus()
       
    }
    
    func changeStopWatchStatus () {
        switch stopWatchStatus {
        case .start:
            timer?.resume()
        case .pause:
            timer?.suspend()
        case .stop:
            timer?.cancel()
            timer = nil
        }
    }
    
    func initTimer() {
        if timer == nil {
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            timer?.schedule(deadline: .now(), repeating: 1)
            timer?.setEventHandler(handler: { [self] in
                self.totalTime += 1.0
                initTimerText(time: totalTime)
            })
        }
    }
    
    func initTimerText(time: Double) {
        let hour = (Int)(fmod((totalTime/60/60), 12))
        let minute = (Int)(fmod((totalTime/60), 60))
        let second = (Int)(fmod(totalTime, 60))
        
        self.hourLabel.text = String(format: "%02d", hour)
        self.minuteLabel.text = String(format: "%02d", minute)
        self.secondLabel.text = String(format: "%02d", second)
    }
    
       

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
  
    @IBAction func pauseButtonTapped(_ sender: Any) {
        if isPlaying {
            stopWatchStatus = .pause
            isPlaying = false
            setButton("재시작")
            CustomLocationManager.shared.stopTracking()
        } else {
            stopWatchStatus = .start
            isPlaying = true
            setButton("일시정지")
            CustomLocationManager.shared.startTracking()
        }
        changeStopWatchStatus()
    }
    
    
    @IBAction func savedButtonTapped(_ sender: Any) {
        let savedFilePath = savedGpxFile()
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        savedUserRunningData(dist: totalRunningDistance, date: dateFormatter.string(from: now), duration: totalTime, gpx: savedFilePath)
        
        CustomLocationManager.shared.stopTracking()
        LocationService.shared.locationDataArray.removeAll()
        self.dismiss(animated: true) {
            self.parent?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func savedGpxFile() -> String {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let folderURL = documentsURL.appendingPathComponent("GPX")
        
        if !fileManager.fileExists(atPath: folderURL.path) {
            do {
                try fileManager.createDirectory(atPath: folderURL.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                    NSLog("Error")
                }
            }
        
        let gpxURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("GPX")
        let gpxFileURL = gpxURL.appendingPathComponent(getDate())
        
        
        var gpxFileCreateString : String = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n" +
        "<gpx xmlns=\"http://www.topografix.com/GPX/1/1\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n" +
        "xsi:schemaLocation=\"http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd\"\n" +
          "version=\"1.1\"\n" +
          "creator=\"gpx-poi.com\">\n"
        
        LocationService.shared.locationDataArray.forEach {
            gpxFileCreateString.append("<wpt lat=\"\($0.coordinate.latitude)\" lon=\"\($0.coordinate.longitude)\">\n")
            gpxFileCreateString.append("<time>\($0.timestamp)</time>\n")
            gpxFileCreateString.append("</wpt>\n")
        }
        
        gpxFileCreateString.append("</gpx>")
        
        
        do {
            try gpxFileCreateString.write(to: gpxFileURL, atomically: true, encoding: .utf8)
        } catch {
            print(error)
        }
        
        return gpxFileURL.absoluteString
    }
    
    func savedUserRunningData(dist: Double, date: String, duration: Double, gpx: String) {
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.string(from: now)
        
        let defaults = UserDefaults.standard
        let dict = ["Distance" : dist, "Date" : date, "Duration" : duration, "GpxURL" : gpx] as [String : Any]
        let appDataInfo = RunningDataInfo.shared
        defaults.set(dict, forKey: "SavedRunningData"+"\(appDataInfo.index)")
        appDataInfo.index += 1
        print(UserDefaults.standard.value(forKey: "SavedRunningData"+"\(appDataInfo.index-1)") as Any)
        print("Global Index >>>> \(appDataInfo.index)")
    }
    
    func getDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: now) + ".gpx"
    }
    
    func updatingProgressBar() {
        if let text = goalMeterTextLabel.text {
            let numberFormatter = NumberFormatter()
            let totalDistanceFromUILabel = numberFormatter.number(from: text)?.doubleValue
            let remain = (Float(totalRunningDistance) / Float(totalDistanceFromUILabel!))
            runningProgressBar.progress = remain
        }
    }
        
}

extension RecordViewController: CustomLocationManagerDelegate {
    func customLocationManager(didUpdate locations: [CLLocation]) {
        
        
        print("UpDating MYLOCATION!!!! >>>>")
        // 위치가 변할때마다 뛴 거리만큼 더해줌
        let currentLocation : CLLocation
        currentLocation = locations.last!

        if LocationService.shared.locationDataArray.count > 1 {
            let prevLocation = LocationService.shared.locationDataArray.last!
            totalRunningDistance += (prevLocation.distance(from: currentLocation) / 1000)
            runningDistanceTextLabel.text = String(format: "%.2f", totalRunningDistance)
        }
        
        if let text = goalMeterTextLabel.text {
            let numberFormatter = NumberFormatter()
            let totalDistanceFromUILabel = numberFormatter.number(from: text)?.doubleValue

            if(totalRunningDistance <= totalDistanceFromUILabel!) {
                updatingProgressBar()
            } else {
                return
            }
        }
        // 지도에 그려줄 PolyLine용 위도경도 정보들을 SingleTon LocationService의 locationData에 던져줌
        LocationService.shared.locationDataArray.append(locations.last!)
        
        
    }
    
    func setButton(_ string: String) {
        self.pauseButton.setTitle(string, for: .normal)
        self.pauseButton.setTitle(string, for: .highlighted)
    }
}

