//
//  JZCompany.swift
//  jianzhi
//
//  Created by daniel on 16/1/6.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZCompany: NSObject, Mappable, NSCopying {
    
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
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let cmp = JZCompany()
        cmp.id = id
        cmp.user = user
        cmp.name = name
        cmp.logo = logo
        cmp.descriptions = descriptions
        cmp.addressCode = addressCode
        cmp.address = address
        
        return cmp
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
