//
//  JZJob.swift
//  jianzhi
//
//  Created by daniel on 16/1/6.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZJobStatus : Int {
    case none = 0
    case pending = 1
    case deactive = 2
}

enum JZSalaryTypeBy : Int {
    case none = 0
    case hour = 1, day = 2, month = 3, once = 4
    
    static let names = ["", "每小时", "每天", "每月", "一次性"]
    
    func nameValue() -> String {
        return JZSalaryTypeBy.names[self.rawValue]
    }
}

class JZJob: NSObject, Mappable {
    
    var id : Int?
    
    var user : JZBossUserInfo?
    
    var title : String?
    
    var detail : String?
    
    var salary : Int?
    
    var salaryType : JZSalaryTypeBy?
    
    var status : Int? = 0
    
    var statusType : JZJobStatus? {
        get {
            return JZJobStatus(rawValue: status ?? 0)
        }
        set {
            status = newValue?.rawValue
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        title       <- map["title"]
        detail      <- map["detail"]
        salary      <- map["salary"]
        salaryType  <- map["salaryType"]
        
    }
    
}
