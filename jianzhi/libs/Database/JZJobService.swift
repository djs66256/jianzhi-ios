//
//  JZJobService.swift
//  jianzhi
//
//  Created by daniel on 16/2/27.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobService: NSObject {
    static let instance = JZJobService()
    
    var db : JZUserDataBase?
    
    func saveJob(job: JZJob) {
        db?.insertJob(job, ignoreIfExist: false, callback: {})
    }
}
