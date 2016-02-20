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
            return self.currentUser != nil && cookieForUser()?.count > 0
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
                
                let oldValue = self.user
                self.user = newValue
                
                JZUserService.instance.save(newValue!)
                if oldValue?.uid != newValue!.uid {
                    setupUserService()
                }
            }
            else {
                clearUserService()
                self.user = nil
                NSUserDefaults.standardUserDefaults().removeObjectForKey(myInfoKey)
            }
        }
    }
    
    override init() {
        super.init()
        
        if isLogin {
            setupUserService()
        }
        else {
            clearUserService()
        }
    }
    
    private func cookieForUser() -> [NSHTTPCookie]? {
        return NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(HTTP.baseUrl)
    }
    
    private func setupUserService() {
        let db = JZUserDataBase(path: JZPath.userPath(user!.uid, path: "db", file: "user.db")!)
        JZUserService.instance.db = db
        JZMessageService.instance.db = db
        JZMessageGroupService.instance.db = db
        JZSocketManager.sharedManager.disconnect()
        JZMessageGroupService.instance.initGroups({
            JZSocketManager.sharedManager.connect()
        })
    }
    
    private func clearUserService() {
        JZSocketManager.sharedManager.disconnect()
        JZUserService.instance.db = nil
        JZMessageService.instance.db = nil
        JZMessageGroupService.instance.db = nil
        JZMessageGroupService.instance.initGroups({})
        
        if let cookies = cookieForUser() {
            cookies.forEach {
                NSHTTPCookieStorage.sharedHTTPCookieStorage().deleteCookie($0)
            }
        }
    }
    
//    func updateUser(user:JZUserInfo, callback:(JZUserInfo?)->Void) {
//        JZUserViewModel.userInfo(user.uid, success: { (newUser) -> Void in
//            user.nickName = newUser.nickName
//            user.gender = newUser.gender
//            user.avatar = newUser.avatar
//            user.descriptions = newUser.descriptions
//            user.userType = newUser.userType
//            user.userName = newUser.userName
//            callback(user)
//            
//            NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.UserUpdated, object: user.uid, userInfo: ["user" : user])
//            }, failure: { _ in
//                callback(nil)
//        })
//    }
//    
//    func addUpdateUserListener(listener: JZUserUpdateProtocol) {
//        autoUpdateUsersListeners.append(listener)
//    }
//    func removeUpdateUserListener(listener: JZUserUpdateProtocol) {
//        if let index = autoUpdateUsersListeners.indexOf({ $0 === listener }) {
//            autoUpdateUsersListeners.removeAtIndex(index)
//        }
//    }
}
