//
//  JZJobseekerUserInfo.swift
//  jianzhi
//
//  Created by daniel on 16/1/6.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobseekerUserInfo: JZUserInfo {
    var resume: JZResume?
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        resume <- map["resume"]
    }
}
