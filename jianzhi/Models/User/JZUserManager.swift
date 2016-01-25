//
//  UserManager.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserManager: NSObject {
    static let sharedManager = JZUserManager()
    
    var isLogin: Bool = false
    
    var currentUser: JZUserInfo?
    
//    var myInfo: JZMyInfo? = NSUserDefaults.standardUserDefaults().objectForKey("myInfo") as? JZMyInfo
//
//    func updateMyInfo(myInfo: JZMyInfo) {
//        NSUserDefaults.standardUserDefaults().setObject(myInfo, forKey: "myInfo")
//    }
}
