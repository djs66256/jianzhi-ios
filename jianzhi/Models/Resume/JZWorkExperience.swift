//
//  JZWorkExperience.swift
//  jianzhi
//
//  Created by daniel on 16/1/3.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZWorkExperience: NSObject, Mappable {
    
    var id : Int?
    
    var companyName : String?
    
    var position : String?
    
    var descriptions : String?
    
    var fromTime : NSDate?
    
    var toTime : NSDate?
    
    override init() {
        
    }
    
    convenience init(_ copy: JZWorkExperience) {
        self.init()
        id = copy.id
        mergeFrom(copy)
    }
    
    func mergeFrom(copy: JZWorkExperience) {
        companyName = copy.companyName
        position = copy.position
        descriptions = copy.descriptions
        fromTime = copy.fromTime
        toTime = copy.toTime
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        companyName     <- map["companyName"]
        position        <- map["position"]
        descriptions    <- map["description"]
        fromTime        <- (map["fromTime"], JZServerDateTransforms())
        toTime          <- (map["toTime"], JZServerDateTransforms())
    }
}
