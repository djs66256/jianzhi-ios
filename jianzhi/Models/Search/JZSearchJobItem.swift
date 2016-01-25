//
//  JZSearchJobItem.swift
//  jianzhi
//
//  Created by daniel on 16/1/24.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSearchBaseItem: NSObject {
}

class JZSearchJobItem: JZSearchBaseItem, Mappable {

    var id: Int?
    var title: String?
    var time: NSDate?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        time <- map["time"]
    }
}
