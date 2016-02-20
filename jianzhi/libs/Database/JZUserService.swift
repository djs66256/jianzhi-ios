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
    
    var db: JZUserDataBase? // = JZUserDataBase.sharedDataBase
    
    func findUserById(uid: Int, callback:(JZUserInfo)->Void) {
        db?.findUserById(uid) { (user) -> Void in
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
        db?.insertUser(user, ignoreIfExists: true)
        updateUser(user) {
            if let user = $0 {
                self.db?.insertUser(user, ignoreIfExists: false)
            }
        }
        return user
    }
    
    private func updateUser(user:JZUserInfo, callback:(JZUserInfo?)->Void) {
        JZUserViewModel.userInfo(user.uid, success: { (newUser) -> Void in
            user.nickName = newUser.nickName
            user.gender = newUser.gender
            user.avatar = newUser.avatar
            user.descriptions = newUser.descriptions
            user.userType = newUser.userType
            user.userName = newUser.userName
            callback(user)
            
            NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.UserUpdated, object: user.uid, userInfo: ["user" : user])
            }, failure: { _ in
                callback(nil)
        })
    }
    
    func save(user: JZUserInfo) {
        self.db?.insertUser(user, ignoreIfExists: false)
    }
}
