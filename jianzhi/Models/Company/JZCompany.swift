//
//  JZCompany.swift
//  jianzhi
//
//  Created by daniel on 16/1/6.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZCompany: NSObject, Mappable {
    
    var id : Int?
    
    var user : JZBossUserInfo?
    
    var name : String?
    
    var logo : String?
    
    var descriptions : String?
    
    var addressCode : Int?
    
    var address : String?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        descriptions    <- map["description"]
        addressCode     <- map["addressCode"]
        address         <- map["address"]
    }
}
