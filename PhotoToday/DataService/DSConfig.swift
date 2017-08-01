//
//  DSConfig.swift
//  PhotoToday
//
//  Created by NS on 7/27/17.
//  Copyright © 2017 Sinhngn. All rights reserved.
//

//This class has support Objective - C

import Foundation

class DSConfig: NSObject {
    
    // Verbose show logs
    static var isShowLog: Bool {
        return true
    }
    
    // 0: Production, 1: Debug , 2: RC.
    static var isDebugType: Int {
        return 0
    }
    
    var domain: String {
        // 0: Production, 1: Debug , 2: RC.
        switch DSConfig.isDebugType {
        case 0:
            return "http://www.nationalgeographic.com"
        case 1, 2:
            return "http://www.nationalgeographic.com"
        default:
            //HAVE TO setup Production URL
            return "http://www.nationalgeographic.com"
        }
    }
}
