//
//  JZUserService.swift
//  jianzhi
//
//  Created by daniel on 16/2/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserService: JZService {
    let instance = JZUserService()
    
    private let db = JZUserDataBase.sharedDataBase
    
    func findUserById(uid: Int, callback:(JZUserInfo)->Void) {
        db.findUserById(uid) { (user) -> Void in
            if let user = user {
                callback(user)
            }
            else {
                let user = createUpdateUser(uid)
                callback(user)
            }
        }
    }
    
    private func createUpdateUser(uid:Int) -> JZUserInfo {
        let user = JZUserInfo()
        user.uid = uid
        return user
    }
}
