//
//  JZProvince.swift
//  jianzhi
//
//  Created by daniel on 16/1/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZProvince: NSObject, JZDataBaseObject {

    var id : Int = 0
    var province : String = ""
    
    init(id: Int, province: String) {
        self.id = id
        self.province = province
        super.init()
    }
    
    override required init() {
        super.init()
    }
    
    func database(map: JZDataBaseMapper) {
        id          <- (map, "id")
        province    <- (map, "province")
    }
}
