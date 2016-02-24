//
//  JZMapAnnotation.swift
//  jianzhi
//
//  Created by daniel on 16/1/11.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZMapAnnotationType : Int {
    case Default = 0, Company = 2, Person = 1
}

class JZMapAnnotation: BMKPointAnnotation, Mappable, MappableCluster {
    
    var type = JZMapAnnotationType.Default
    
    var latitude: Double = 0
    var longitude: Double = 0
    
    override var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(latitude, longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        
        latitude    <- map["latitude"]
        longitude   <- map["longitude"]
    }
    
    static func objectForMapping(map: Map) -> Mappable? {
        if let typeValue = map.JSONDictionary["type"] as? Int, let type = JZMapAnnotationType(rawValue: typeValue) {
            switch type {
            case .Person: return JZPersonMapAnnotation()
            case .Company: return JZCompanyMapAnnotation()
            default: return nil
            }
        }
        return nil
    }
}

class JZPersonMapAnnotation: JZMapAnnotation {
    
    var uid = 0
    var avatar: String?
    
    override init() {
        super.init()
    }

    required init?(_ map: Map) {
        fatalError("init has not been implemented")
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        uid         <- map["uid"]
        title       <- map["title"]
        avatar      <- map["avatar"]
    }
}

class JZCompanyMapAnnotation: JZMapAnnotation {
    
    var uid = 0
    var cid = 0
//    var companyName = ""
    var avatar: String?
    
    override init() {
        super.init()
    }

    required init?(_ map: Map) {
        fatalError("init has not been implemented")
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        uid         <- map["uid"]
        cid         <- map["cid"]
        title       <- map["title"]
        avatar      <- map["avatar"]
    }
}
