//
//  JZCity.swift
//  jianzhi
//
//  Created by daniel on 16/1/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZCity: NSObject {
    
    var id : Int!
    var city : String!
    var province : JZProvince?
    
    init(id: Int, city: String) {
        self.id = id
        self.city = city
        super.init()
    }
}
