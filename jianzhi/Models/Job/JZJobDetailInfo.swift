//
//  JZJobDetailInfo.swift
//  jianzhi
//
//  Created by daniel on 16/1/25.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobDetailInfo: NSObject, Mappable {
    
    var id : Int?
    var title : String?
    var detail : String?
    var salary : Int?
    var salaryType : JZSalaryTypeBy?
    
    var uid: Int?
    var nickName: String?
    var headImage: String?
    
    var cid: Int?
    var cname: String?
    var cdescription: String?
    var address: String?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
    }

    func mapping(map: Map) {
        id          <- map["cid"]
        title       <- map["jtitle"]
        detail      <- map["jdetail"]
        salary      <- map["salary"]
        salaryType  <- map["salaryType"]
        
        uid         <- map["uid"]
        nickName    <- map["nickName"]
        headImage   <- map["headImage"]
        
        cid         <- map["cid"]
        cname       <- map["cname"]
        cdescription <- map["cdescription"]
        address     <- map["address"]
    }
    
    func toJobObject() -> JZJob {
        let job = JZJob()
        job.id = id
        job.title = title
        job.detail = detail
        job.salary = salary
        job.salaryType = salaryType ?? .none
        
        let user = JZBossUserInfo()
        user.uid = uid ?? 0
        user.nickName = nickName
        
        job.user = user
        return job
    }
}
