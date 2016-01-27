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

class JZBaseFilter: NSObject {
    
}

class JZJobFilter: JZBaseFilter, Mappable {
    
    var timeOrder: JZFilterOrder = .asc
    var jobClass: Int?
    var district: Int?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        timeOrder <- map["timeOrder"]
        jobClass <- map["jobClass"]
        district <- map["district"]
    }

}


class JZPersonFilter: JZBaseFilter {
    var educationLevel: JZEducationLevel?
}
