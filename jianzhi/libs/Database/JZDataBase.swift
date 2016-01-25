//
//  JZDataBase.swift
//  jianzhi
//
//  Created by daniel on 16/1/12.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZDataBase: NSObject {
    
    var db : FMDatabase!
    
    let queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL)
    
    override init() {
        super.init()
        let path = dbPath()
        if path != nil {
            db = FMDatabase(path: path)
            db.open()
            prepareDatabase()
        }
    }
    
    func dbPath() -> String? {
        JZLogError("Must override!")
        return nil
    }
    
    func prepareDatabaseStatement() -> String? {
        return nil
    }
    
    func prepareDatabase() {
        let statement = self.prepareDatabaseStatement()
        if statement != nil {
            execuse({
                if self.db.executeStatements(statement) {
                    JZLogInfo("Create database success: \(self.classForCoder)")
                }
                else {
                    JZLogError("Create database failed: \(self.classForCoder)")
                }
            })
        }
    }
    
    func execuse(block: dispatch_block_t) {
        dispatch_async(queue, block)
    }
    
    func callback(block: dispatch_block_t) {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
}
