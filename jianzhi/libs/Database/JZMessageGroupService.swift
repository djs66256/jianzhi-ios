//
//  JZMessageGroupService.swift
//  jianzhi
//
//  Created by daniel on 16/2/15.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageGroupService: JZService {
    static let instance = JZMessageGroupService()
    
    var db: JZUserDataBase?
    
    var groups = [JZMessageGroup]()
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("userUpdated:"), name: JZNotification.UserUpdated, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func initGroups(compeletion: ()->Void) {
        groups = []
        db?.findGroups { (groups) -> Void in
            self.groups = self.sortGroups(groups)
            NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.MessageGroupReload, object: nil)
            compeletion()
        }
    }
    
    func userUpdated(noti: NSNotification) {
        if let user = noti.userInfo?["user"] as? JZUserInfo {
            var needReload = false
            for group in groups {
                if group.user?.uid == user.uid {
                    group.user = user
                    needReload = true
                }
            }
            if needReload {
                NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.MessageGroupReload, object: nil)
            }
        }
    }
    
    private func sortGroups(groups: [JZMessageGroup]) -> [JZMessageGroup] {
        return groups.sort { (g1, g2) -> Bool in
            if let m1 = g1.lastMessage, let m2 = g2.lastMessage {
                return m1.id > m2.id
            }
            if let _ = g1.lastMessage {
                return true
            }
            else if let _ = g2.lastMessage {
                return false
            }
            else {
                return g1.id > g2.id
            }
        }
    }
    
    private func maxGroupId() -> Int {
        var id = 0
        groups.forEach { (group) -> () in
            if id < group.id {
                id = group.id
            }
        }
        return id
    }
    
    private func createChatGroup(uid: Int) -> JZMessageGroup {
        let user = JZUserInfo()
        user.uid = uid
        let group = JZMessageGroup()
        group.id = maxGroupId() + 1
        group.type = .Chat
        group.user = user
        
        JZUserService.instance.findUserById(uid) { (user) -> Void in
            group.user = user
            NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.MessageGroupReload, object: nil)
        }
        db?.insertMessageGroup(group, ignoreIfExists: false)
        
        self.groups.insert(group, atIndex: 0)
        
        return group
    }
    
    func findGroupByReceivedMessage(message: JZSockMessage, callback:(JZMessageGroup)->Void) {
        let groupType : JZMessageGroupType = (message.type == .Post) ? .Post : .Chat
        if let index = groups.indexOf({ ($0.user?.uid == message.uid) }) {
            callback(groups[index])
        }
        else {
            let group = createChatGroup(message.uid)
            
            callback(group)
        }
    }
    
    func remove(group: JZMessageGroup) {
        if let index = groups.indexOf({ $0 == group }) {
            db?.removeGroupById(group.id)
            db?.removeMessagesByGroup(group.id)
            groups.removeAtIndex(index)
        }
    }
    
    func clearUnread(group: JZMessageGroup) {
        
    }
}
