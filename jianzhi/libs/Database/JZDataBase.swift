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
    
    init(path: String) {
        JZLogInfo("DB Path: \(path)")
        super.init()
        db = FMDatabase(path: path)
        db.open()
        prepareDatabase()
    }
    
//    func dbPath() -> String? {
//        JZLogError("Must override!")
//        return nil
//    }
    
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
    
    func update(sql:String) {
        update(sql, nil)
    }
    
    func update(sql:String, _ params:[NSObject: AnyObject]?) {
        execuse {
            self.db.executeUpdate(sql, withParameterDictionary: params)
        }
    }
    
    func insert(sql:String, _ params:[NSObject: AnyObject]?, callback:(Int?)->Void) {
        execuse {
            if self.db.executeUpdate(sql, withParameterDictionary: params) {
                let rowId: Int = Int(self.db.lastInsertRowId())
                callback(rowId)
            }
            else {
                callback(nil)
            }
        }
    }
    
    func queryOne<T>(query:String, params:[NSObject: AnyObject]?, unpack:(FMResultSet)->T?, callback:(T?)->Void) {
        execuse {
            var obj : T?
            if let result = self.db.executeQuery(query, withParameterDictionary: params) {
                while result.next() {
                    obj = unpack(result)
                    break
                }
                result.close()
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                callback(obj)
            }
        }
    }
    
    func queryAll<T>(query:String, params:[NSObject: AnyObject]?, unpack:(FMResultSet)->T?, callback:([T])->Void) {
        execuse {
            var ret = [T]()
            if let result = self.db.executeQuery(query, withParameterDictionary: params) {
                while result.next() {
                    if let obj = unpack(result) {
                        ret.append(obj)
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                callback(ret)
            }
        }
    }
    
    func queryAll<T: JZDataBaseObject>(sql:String, params:[String: AnyObject]?, callback:([T])->Void) {
        queryAll(sql, params: params, unpack: { (result) -> T? in
            return JZDataBaseUnpackageMapper.unpack(result)
            }, callback: callback)
    }
    
    func queryAll<T: JZDataBaseObject>(sql:String, callback:([T])->Void) {
        queryAll(sql, params: nil, callback: callback)
    }
    
}

