//
//  JZMessage.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZMessageType : Int {
    case None = 0, Message = 1, Job = 2, Person = 3
}

class JZMessage: NSObject {

//    var fromUser : JZUserInfo?
//    
//    var toUser : JZUserInfo?
    
    var user: JZUserInfo?
    
    var content : String?
    
    var type : JZMessageType = .None
    
    var group: JZMessageGroup?
    
    var time: NSDate?
    
//    init(fromUser: JZUserInfo, toUser: JZUserInfo, type: JZMessageType) {
//        self.fromUser = fromUser
//        self.toUser = toUser
//        self.type = type
//        super.init()
//    }
}
