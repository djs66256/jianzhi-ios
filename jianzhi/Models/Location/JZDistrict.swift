//
//  JZDistrict.swift
//  jianzhi
//
//  Created by daniel on 16/1/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZDistrict: NSObject {

    var id : Int!
    var district : String!
    var city : JZCity?
    
    init(id: Int, district: String) {
        self.id = id
        self.district = district
        super.init()
    }
}
