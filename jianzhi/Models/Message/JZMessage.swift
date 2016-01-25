//
//  JZMessage.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZMessageType : Int {
    case message = 1, job = 2, card = 3
}

class JZMessage: NSObject {

    var fromUser : JZUserInfo
    
    var toUser : JZUserInfo
    
    var content : String?
    
    var typeValue : Int?
    
    var type : JZMessageType
    
    var job : JZJob?
    
    init(fromUser: JZUserInfo, toUser: JZUserInfo, type: JZMessageType) {
        self.fromUser = fromUser
        self.toUser = toUser
        self.type = type
        super.init()
    }
    
    
}
