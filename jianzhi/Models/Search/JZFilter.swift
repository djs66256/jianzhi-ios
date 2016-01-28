//
//  JZJobFilter.swift
//  jianzhi
//
//  Created by daniel on 16/1/24.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZFilterOrder : String {
    case asc = "asc"
    case desc = "desc"
}

class JZBaseFilter: NSObject, Mappable {
    
    var start: Int = 0
    var count: Int = 20
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        start   <- map["start"]
        count   <- map["count"]
    }
}

class JZJobFilter: JZBaseFilter {
    
    var timeOrder: JZFilterOrder = .asc
    var jobClass: Int?
    var district: Int?
    
    override init() {
        super.init()
    }

    required init?(_ map: Map) {
        fatalError("init has not been implemented")
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        timeOrder <- map["timeOrder"]
        jobClass <- map["jobClass"]
        district <- map["district"]
    }

}


class JZPersonFilter: JZBaseFilter {
    var educationLevel: JZEducationLevel?
    
    override init() {
        super.init()
    }

    required init?(_ map: Map) {
        fatalError("init has not been implemented")
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        educationLevel <- map["level"]
    }
}
