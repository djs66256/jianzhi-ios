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
    var title: String = ""
    var type = JZMessageGroupType.None
    var resume: JZResume?
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


class JZMessageGroupManager: NSObject {
    var groups = [JZMessageGroup]()
    
    override init() {
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("save"), name: UIApplicationDidEnterBackgroundNotification, object: nil)
    }
    
    func load() {
        
    }
    
    func save() {
        
    }
}