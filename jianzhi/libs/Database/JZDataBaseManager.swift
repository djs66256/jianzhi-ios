//
//  JZDataBaseManager.swift
//  jianzhi
//
//  Created by daniel on 16/1/12.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZDataBaseManager: NSObject {
    
    static let sharedManager = JZDataBaseManager()
    
    let daoList : [JZDataBase]!
    
    override init() {
        daoList = [JZLocationDataBase.sharedDataBase]
        super.init()
    }
    
}
