//
//  JZSockMessage.swift
//  jianzhi
//
//  Created by daniel on 16/2/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSockMessage: NSObject, Mappable {
    
//    var id: Int = 0
    var uuid: String = ""
    var uid: Int = 0
    var text: String = ""
//    var date = NSDate()
    var type : JZMessageType = .None
    var time: NSDate?
//    var group: JZMessageGroup
    
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
        text    <- map["text"]
        type    <- map["type"]
        time    <- map["time"]
    }
}
