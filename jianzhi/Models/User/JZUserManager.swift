//
//  UserManager.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZUserUpdateProtocol: NSObjectProtocol {
    func didUpdateUser(user: JZUserInfo)
}

class JZUserManager: NSObject {
    static let sharedManager = JZUserManager()
    
    private var autoUpdateUsers = [JZAutoUpdateUserInfo]()
    private var autoUpdateUsersListeners = [JZUserUpdateProtocol]()
    
    let myInfoKey = "myInfoKey"
    
    var isLogin: Bool {
        get {
            return self.currentUser != nil
        }
    }
    
    private var user: JZUserInfo?
    
    var currentUser: JZUserInfo? {
        get {
            if self.user == nil {
                let json = NSUserDefaults.standardUserDefaults().objectForKey(myInfoKey) as? NSDictionary
                let user = Mapper<JZUserInfo>().map(json)
                self.user = user
                return user
            }
            else {
                return self.user
            }
        }
        set {
            if newValue != nil {
                let user = Mapper().toJSON(newValue!)
                NSUserDefaults.standardUserDefaults().setObject(user, forKey: myInfoKey)
                self.user = newValue
                
                JZUserService.instance.save(newValue!)
            }
            else {
                self.user = nil
                NSUserDefaults.standardUserDefaults().removeObjectForKey(myInfoKey)
            }
        }
    }
    
    func updateUser(user:JZUserInfo, callback:(JZUserInfo?)->Void) {
        JZUserViewModel.userInfo(user.uid, success: { (newUser) -> Void in
            user.nickName = newUser.nickName
            user.gender = newUser.gender
            user.headImage = newUser.headImage
            user.descriptions = newUser.descriptions
            user.userType = newUser.userType
            user.userName = newUser.userName
            callback(user)
            
            NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.UserUpdated, object: user.uid, userInfo: ["user" : user])
            }, failure: { _ in
                callback(nil)
        })
    }
    
    func addUpdateUserListener(listener: JZUserUpdateProtocol) {
        autoUpdateUsersListeners.append(listener)
    }
    func removeUpdateUserListener(listener: JZUserUpdateProtocol) {
        if let index = autoUpdateUsersListeners.indexOf({ $0 === listener }) {
            autoUpdateUsersListeners.removeAtIndex(index)
        }
    }
}
