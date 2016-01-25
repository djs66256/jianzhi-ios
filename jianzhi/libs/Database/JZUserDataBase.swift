//
//  JZUserDataBase.swift
//  jianzhi
//
//  Created by daniel on 16/1/12.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserDataBase: JZDataBase {

    override func prepareDatabaseStatement() -> String {
        return "CREATE TABLE IF NOT EXIST user {"
        + ""
        + "}"
    }
    
}
