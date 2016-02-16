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
    
    let db = JZUserDataBase()
    
    func save(message: JZMessage) {
        db.saveMessage(message)
    }
    
    func markUploaded(message: JZMessage) {
        message.uploaded = true
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
