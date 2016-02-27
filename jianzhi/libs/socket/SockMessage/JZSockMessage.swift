//
//  JZSockMessage.swift
//  jianzhi
//
//  Created by daniel on 16/2/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSockMessage: NSObject, Mappable {
    
    var uuid: String = ""
    var uid: Int = 0
    var text: String = ""

    var type : JZMessageType = .None
    var time: NSDate?
    
    var cid: Int?
    var jid: Int?
    
    var job: JZJob?
    var nameCard: JZUserInfo?

//    var readed = false
//    var uploaded = false
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        uuid    <- map["uuid"]
        uid     <- map["uid"]
        cid     <- map["cid"]
        jid     <- map["jid"]
        job     <- map["job"]
        nameCard <- map["nameCard"]
        text    <- map["text"]
        type    <- map["type"]
        time    <- (map["time"], JZServerDateTransforms())
    }
}
