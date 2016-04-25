//
//  JZMessageGroup.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZMessageGroupType : Int {
    case None = 0, Chat = 1, Post = 2
}

class JZMessageGroup: NSObject {
    var id: Int = 0
    var title: String {
        get {
            if type == .Chat {
                return user?.nickName ?? ""
            }
            else {
                return job?.title ?? ""
            }
        }
        set {
            
        }
    }
    var type = JZMessageGroupType.None
//    var resume: JZResume?
    var job: JZJob?
    var user: JZUserInfo?
    var lastMessage: JZMessage?
    var unread: Int = 0
    var createDate = NSDate()
    
    var placeholderImage : UIImage? {
            return UIImage(named: "anno")
    }
    
    var avatarUrl : NSURL? {
        if type == .Chat {
            return user?.avatarUrl
        }
        else {
            return nil
        }
    }
    
    var detail: String? {
        if let messageType = lastMessage?.type {
            switch messageType {
            case .Job: return "你有一个新的职位邀请"
            case .Post: return "你有一个新的名片"
            case .Person: return "你有一个新的名片"
            case .Message: return lastMessage?.text
            default: return nil
            }
        }
        return nil
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? JZMessageGroup {
            guard type == object.type else { return false }
            
            switch type {
            case .Chat: return user != nil && object.user != nil && user!.uid == object.user!.uid
            case .Post: return false
            default: return false
            }
        }
        else { return false }
    }
}

func ==(lhs: JZMessageGroup, rhs: JZMessageGroup) -> Bool {
    if lhs === rhs {
        return true
    }
    if lhs.type == rhs.type {
        switch lhs.type {
        case .Chat: return lhs.user != nil && lhs.user?.uid == rhs.user?.uid
        case .Post: return lhs.job != nil && lhs.job!.id == rhs.job?.id
        default: return false
        }
    }
    return false
}
