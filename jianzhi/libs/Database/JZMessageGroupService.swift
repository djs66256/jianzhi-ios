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
    
    var groups = [JZMessageGroup]()
    var isReady = false
    
    func initGroups(compeletion: ()->Void) {
        JZUserDataBase.sharedDataBase.findGroups { (groups) -> Void in
            self.groups = self.sortGroups(groups)
            NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.MessageGroupReload, object: nil)
            compeletion()
        }
    }
    
    private func sortGroups(groups: [JZMessageGroup]) -> [JZMessageGroup] {
        return groups
    }
    
//    func findByType(type: JZMessageGroupType, uid: Int, rid: Int) -> Bool {
//        guard object != nil else { return false }
//        guard type == object.type else { return false }
//        
//        switch type {
//        case .Person: return user != nil && object.user != nil && user!.uid == object.user.uid
//        case .Resume: return false
//        default: return false
//        }
//
//    }
    
    func touchGroup(group: JZMessageGroup) {
        for g in groups {
            if g.isEqual(group) {
               return
            }
        }
        
        JZUserDataBase.sharedDataBase.insertMessageGroup(group)
    }
    
    func createChatGroup(user: JZUserInfo) -> JZMessageGroup {
        let group = JZMessageGroup()
        group.type = .Chat
        group.user = user
        return group
    }
    
    func findGroupByReceivedMessage(message: JZSockMessage) -> JZMessageGroup {
        let groupType : JZMessageGroupType = (message.type == .Post) ? .Post : .Chat
        if let index = groups.indexOf({ ($0.type == .Chat && $0.user?.uid == message.uid) }) {
            return groups[index]
        }
        else {
            let group = JZMessageGroup()
            group.type = groupType;
//            return createChatGroup(message.uid)
        }
        
        return JZMessageGroup()
    }
}
