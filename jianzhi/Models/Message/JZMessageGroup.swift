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
    var id: Int?
    var title: String?
    var lastMessage: JZMessage?
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