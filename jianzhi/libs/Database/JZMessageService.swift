//
//  JZMessageService.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageService: JZService {
    let db = JZDataBase()
    
    func findByIdentifier(id: String, callback:([JZMessage]?)->Void) {
        db.queryAll("", params: ["":""], unpack: { (set: FMResultSet) -> JZMessage? in
            return nil
            }, callback: callback)
    }
    
    func find() {
//        JZDataBaseCreaterMapper.buildSql(JZMessage.self)
    }
}
