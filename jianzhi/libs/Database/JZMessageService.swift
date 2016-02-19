//
//  JZMessageService.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageService: JZService {
    static let instance = JZMessageService()
    
    let db = JZUserDataBase.sharedDataBase
    
//    func save(message: JZMessage) {
//        if message.id == 0 {
//            db.insertMessage(message)
//        }
//        else {
//            db.updateMessage(message)
//        }
//    }
    
    func insert(message: JZMessage) {
        db.insertMessage(message)
    }
    
    func removeByUuid(uuid: String) {
        db.removeMessageByUuid(uuid)
    }
    
    func setUploaded(uuid: String) {
        db.setMessageUploaded(uuid)
    }
    
    func findAllUnuploaded() -> [JZMessage] {
        return []
    }
    
//    func findByGroup(group: JZMessageGroup, index: Int, count: Int, callback: ([JZMessage])->Void) {
//        if group.id != 0 {
//            db.findByGroupId(group.id, index: index, count: count) { messages in
//                messages.forEach { $0.group = group }
//                callback(messages)
//            }
//        }
//        else {
//            JZLogError("group id can not be 0")
//            callback([])
//        }
//    }
}
