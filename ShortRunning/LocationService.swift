//
//  LocationService.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/10/27.
//

import Foundation

class LocationService {
    
    static var shared = LocationService()
    
    var locationData : [String: Double] = [:] as Dictionary
    
    var locationDataArray : Array<Dictionary<String, Double>> = []
    
//    func setLocationData (lan: Double, lon: Double) {
//        locationData.updateValue(lan, forKey: "lan")
//        locationData.updateValue(lon, forKey: "lon")
//        print(locationData)
//    }
}
