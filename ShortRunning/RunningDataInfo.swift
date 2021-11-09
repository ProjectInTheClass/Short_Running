//
//  RunningDataInfo.swift
//  ShortRunning
//
//  Created by 남영훈 on 2021/11/09.
//

import Foundation

class RunningDataInfo {
    static let shared = RunningDataInfo()
    
    var index : Int = 0
    
    private init() {}
}
