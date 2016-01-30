
//
//  JZDataBaseParser.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZDataBaseproperties {
    case PrimaryKey, AutoIncrement
}

protocol JZDataBaseObject : NSObjectProtocol {
    init()
    func database(map: JZDataBaseMapper)
}

class JZDataBaseMapper {
    
    func map<T>(inout obj: T, _ key: String, _ properties: [JZDataBaseproperties]?) {
        JZLogInfo("[DB] no match object for key")
    }
    
    func map(inout obj: String, _ key:String, _ properties: [JZDataBaseproperties]?) {
    }
    
    func map(inout obj: Int, _ key:String, _ properties: [JZDataBaseproperties]?) {
    }
    
    func map(inout obj: Double, _ key:String, _ properties: [JZDataBaseproperties]?) {
    }
    
    func map(inout obj: NSDate, _ key:String, _ properties: [JZDataBaseproperties]?) {
    }
}

class JZDataBaseUnpackageMapper: JZDataBaseMapper {
    
    private let result : FMResultSet
    
    init(result: FMResultSet) {
        self.result = result
    }
    
    class func unpack<T: JZDataBaseObject>(result: FMResultSet) -> T? {
        let mapper = JZDataBaseUnpackageMapper(result: result)
        
        let obj = T()
        obj.database(mapper)
        
        return obj
    }
    
    override func map(inout obj: String, _ key:String, _ properties: [JZDataBaseproperties]?) {
        obj = result.stringForColumn(key)
    }
    
    override func map(inout obj: Int, _ key:String, _ properties: [JZDataBaseproperties]?) {
        obj = Int(result.intForColumn(key))
    }
    
    override func map(inout obj: Double, _ key:String, _ properties: [JZDataBaseproperties]?) {
        obj = result.doubleForColumn(key)
    }
    
    override func map(inout obj: NSDate, _ key:String, _ properties: [JZDataBaseproperties]?) {
        obj = result.dateForColumn(key)
    }
}

class JZDataBasePackageMapper: JZDataBaseMapper {
    
    var package = [String: AnyObject]()
    
    
    override func map(inout obj: String, _ key:String, _ properties: [JZDataBaseproperties]?) {
        package[key] = obj
    }
    
    override func map(inout obj: Int, _ key:String, _ properties: [JZDataBaseproperties]?) {
        package[key] = obj
    }
    
    override func map(inout obj: Double, _ key:String, _ properties: [JZDataBaseproperties]?) {
        package[key] = obj
    }
    
    override func map(inout obj: NSDate, _ key:String, _ properties: [JZDataBaseproperties]?) {
        package[key] = obj
    }
    
}
/*
create table if not exists (
    id integer auto_increment,

    primary key(id)
);
*/
class JZDataBaseCreaterMapper: JZDataBaseMapper {
    
    var propertiesSql = [String]()
    
    required override init() {
        super.init()
    }
    
    class func buildSql(cls: JZDataBaseObject.Type) -> String {
        let obj = cls.init()
        let mapper = self.init()
        obj.database(mapper)
        let properties = mapper.propertiesSql.joinWithSeparator(",\n")
        let sql = "CREATE TABLE IF NOT EXISTS (\n" + properties + "\n);"
        return sql
    }
    
    override func map(inout obj: String, _ key:String, _ properties: [JZDataBaseproperties]?) {
        propertiesSql.append("\(key) TEXT")
    }
    
    override func map(inout obj: Int, _ key:String, _ properties: [JZDataBaseproperties]?) {
        var sql = "\(key) INTEGER"
        if let properties = properties {
            for property in properties {
                switch property {
                case .AutoIncrement: sql += " AUTOINCREMENT"
                case .PrimaryKey: sql += " PRIMARY KEY"
                }
            }
        }
        propertiesSql.append(sql)
    }
    
    override func map(inout obj: Double, _ key:String, _ properties: [JZDataBaseproperties]?) {
        propertiesSql.append("\(key) DOUBLE")
    }
    
    override func map(inout obj: NSDate, _ key:String, _ properties: [JZDataBaseproperties]?) {
        propertiesSql.append("\(key) DATETIME")
    }
    
}

func <- <T>(inout left: T, right: (JZDataBaseMapper, String)) {
    right.0.map(&left, right.1, nil)
}
func <- (inout left: Int, right: (JZDataBaseMapper, String)) {
    right.0.map(&left, right.1, nil)
}
func <- (inout left: String, right: (JZDataBaseMapper, String)) {
    right.0.map(&left, right.1, nil)
}
func <- (inout left: Double, right: (JZDataBaseMapper, String)) {
    right.0.map(&left, right.1, nil)
}
func <- (inout left: NSDate, right: (JZDataBaseMapper, String)) {
    right.0.map(&left, right.1, nil)
}
func <- <T>(inout left: T, right: (JZDataBaseMapper, String, [JZDataBaseproperties])) {
    right.0.map(&left, right.1, right.2)
}
func <- (inout left: Int, right: (JZDataBaseMapper, String, [JZDataBaseproperties])) {
    right.0.map(&left, right.1, right.2)
}
func <- (inout left: String, right: (JZDataBaseMapper, String, [JZDataBaseproperties])) {
    right.0.map(&left, right.1, right.2)
}
func <- (inout left: Double, right: (JZDataBaseMapper, String, [JZDataBaseproperties])) {
    right.0.map(&left, right.1, right.2)
}
func <- (inout left: NSDate, right: (JZDataBaseMapper, String, [JZDataBaseproperties])) {
    right.0.map(&left, right.1, right.2)
}
