//
//  JZMessageGroup.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZMessageGroupType : Int {
    case None = 0, Person = 1, Resume = 2
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
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? JZMessageGroup {
            guard type == object.type else { return false }
            
            switch type {
            case .Person: return user != nil && object.user != nil && user!.uid == object.user!.uid
            case .Resume: return false
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