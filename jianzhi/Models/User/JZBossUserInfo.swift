//
//  JZBossUserInfo.swift
//  jianzhi
//
//  Created by daniel on 16/1/6.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZBossUserInfo: JZUserInfo {
    var company: JZCompany?
    var jobList = [JZJob]()
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        company <- map["company"]
        jobList <- map["jobList"]
    }
}
