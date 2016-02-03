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

class JZMessage: JZBaseMessage {
    
    var user: JZUserInfo
    //var text: String = ""
    //var date: NSDate
    var type : JZMessageType = .None
    var group: JZMessageGroup
    
    init(user: JZUserInfo, text: String, date: NSDate, type: JZMessageType, group: JZMessageGroup) {
        self.user = user
        self.type = type
        self.group = group
        super.init()
        self.text = text
        self.date = date
    }
    
    override var senderId: String {
        return String(user.uid)
    }
    
    override var senderDisplayName: String {
        return user.nickName ?? ""
    }
    
    override var isMediaMessage: Bool {
        return false
    }
}
