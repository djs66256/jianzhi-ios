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
    
    func updateUser(user:JZUserInfo) {
        JZUserViewModel.userInfo(user.uid, success: { (newUser) -> Void in
            
            }, failure: { })
    }
    
    func addUpdateUserListener(listener: JZUserUpdateProtocol) {
        autoUpdateUsersListeners.append(listener)
    }
    func removeUpdateUserListener(listener: JZUserUpdateProtocol) {
        if let index = autoUpdateUsersListeners.indexOf( == ) {
            autoUpdateUsersListeners.removeAtIndex(index)
        }
    }
}
