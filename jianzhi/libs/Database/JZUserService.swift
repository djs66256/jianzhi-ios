//
//  JZUserService.swift
//  jianzhi
//
//  Created by daniel on 16/2/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserService: JZService {
    static let instance = JZUserService()
    
    private let db = JZUserDataBase.sharedDataBase
    
    func findUserById(uid: Int, callback:(JZUserInfo)->Void) {
        db.findUserById(uid) { (user) -> Void in
            if let user = user {
                callback(user)
            }
            else {
                let user = self.createUpdateUser(uid)
                callback(user)
            }
        }
    }
    
    private func createUpdateUser(uid:Int) -> JZUserInfo {
        let user = JZUserInfo()
        user.uid = uid
        db.insertUser(user)
        JZUserManager.sharedManager.updateUser(user) {
            if let user = $0 {
                self.db.updateUser(user)
            }
        }
        return user
    }
    
    func save(user: JZUserInfo) {
        db.findUserById(user.uid) {
            if $0 != nil {
                self.db.updateUser(user)
            }
            else {
                self.db.insertUser(user)
            }
        }
    }
}
