//
//  JZMapAnnotation.swift
//  jianzhi
//
//  Created by daniel on 16/1/11.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZMapAnnotationType : Int {
    case Default = 0, Company = 1, Person = 2
}

class JZMapAnnotation: BMKPointAnnotation, Mappable {
    
    var type = JZMapAnnotationType.Default
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        coordinate <- map["coor"]
    }
}

class JZPersonMapAnnotation: JZMapAnnotation {
    
    var uid = 0
    var nickName = ""
    var avartar: String?
    
    override init() {
        super.init()
    }

    required init?(_ map: Map) {
        fatalError("init has not been implemented")
    }
}

class JZCompanyMapAnnotation: JZMapAnnotation {
    
    var uid = 0
//    var cid = 0
    var companyName = ""
    var avartar: String?
    
    override init() {
        super.init()
    }

    required init?(_ map: Map) {
        fatalError("init has not been implemented")
    }
}
