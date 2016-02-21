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
    
    var db : JZUserDataBase? // = JZUserDataBase.sharedDataBase
    
//    func save(message: JZMessage) {
//        if message.id == 0 {
//            db.insertMessage(message)
//        }
//        else {
//            db.updateMessage(message)
//        }
//    }
    
    func insert(message: JZMessage) {
        db?.insertMessage(message)
    }
    
    func removeByUuid(uuid: String) {
        db?.removeMessageByUuid(uuid)
    }
    
    func setUploaded(uuid: String) {
        db?.setMessageUploaded(uuid)
    }
    
    func findAllUnuploaded() -> [JZMessage] {
        return []
    }
    
    func findByGroup(group: JZMessageGroup, index: Int, count: Int, callback: ([JZMessage])->Void) {
        if group.id != 0 {
            db?.findMessageByGroup(group, index: index, count: count, callback: callback)
        }
        else {
            JZLogError("group id can not be 0")
            callback([])
        }
    }
    
    func findByUuid(uuid: String, callback: (JZMessage?)->Void) {
        if let db = db {
            db.findMessageByUUID(uuid, callback: callback)
        }
        else {
            callback(nil)
        }
    }
    
    func setReadedByGroup(group: JZMessageGroup) {
        if group.id > 0 {
            db?.setMessageReadedByGroup(group.id)
        }
    }
}
