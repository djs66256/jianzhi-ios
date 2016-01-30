//
//  JZMessageDataBase.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageDataBase: JZDataBase {
    let sharedDataBase = JZMessageDataBase()
    
    override func dbPath() -> String? {
        let path = JZPath.userPath("db/m")
        return path
    }
    
    override func prepareDatabase() {
        
    }
}
