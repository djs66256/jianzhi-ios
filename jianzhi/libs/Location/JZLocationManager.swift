//
//  JZLocationManager.swift
//  jianzhi
//
//  Created by daniel on 16/2/25.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZLocationManager: NSObject {
    static let sharedManager = JZLocationManager()
    
    var mapPoint: BMKMapPoint?
    var coor: CLLocationCoordinate2D?
    
    func updateCoordinate(coor: CLLocationCoordinate2D) -> Bool {
        var ret = false
        if let preCoor = self.coor {
            let prePoint = BMKMapPointForCoordinate(preCoor)
            let point = BMKMapPointForCoordinate(coor)
            let distance = BMKMetersBetweenMapPoints(prePoint, point)
            if distance > 500 {
                uploadLocation(coor)
                ret = true
            }
        }
        else {
            uploadLocation(coor)
            ret = true
        }
        
        self.coor = coor
        
        return ret
    }
    
    
    private func uploadLocation(coor: CLLocationCoordinate2D) {
        JZUserViewModel.uploadCoordinate(coor, success:{}, failure:{_ in })
    }

    
}
