//
//  JZProvince.swift
//  jianzhi
//
//  Created by daniel on 16/1/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZProvince: NSObject {

    var id : Int!
    var province : String!
    
    init(id: Int, province: String) {
        self.id = id
        self.province = province
        super.init()
    }
}
