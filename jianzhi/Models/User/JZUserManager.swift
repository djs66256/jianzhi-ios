//
//  UserManager.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserManager: NSObject, BMKLocationServiceDelegate {
    static let sharedManager = JZUserManager()
    
    private let locationService = BMKLocationService()
    var userLocation: BMKUserLocation?
    
    private let myInfoKey = "myInfoKey"
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
        locationService.delegate = self
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
        JZJobService.instance.db = db
        JZSocketManager.sharedManager.disconnect()
        JZMessageGroupService.instance.initGroups({
            JZSocketManager.sharedManager.connect()
        })
        
        locationService.startUserLocationService()
        NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.Login, object: nil)
    }
    
    private func clearUserService() {
        JZSocketManager.sharedManager.disconnect()
        JZUserService.instance.db = nil
        JZMessageService.instance.db = nil
        JZMessageGroupService.instance.db = nil
        JZJobService.instance.db = nil
        JZMessageGroupService.instance.initGroups({})
        userLocation = nil
        
        locationService.stopUserLocationService()
        
        if let cookies = cookieForUser() {
            cookies.forEach {
                NSHTTPCookieStorage.sharedHTTPCookieStorage().deleteCookie($0)
            }
        }
        NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.Logout, object: nil)
    }
    
    // MARK: - map delegate
    func didUpdateUserHeading(userLocation: BMKUserLocation)
    {
        //NSLog(@"heading is %@",userLocation.heading);
    }
    //处理位置坐标更新
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation)
    {
        //NSLog("didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//        mapView.updateLocationData(userLocation)
        self.userLocation = userLocation
        
        let coor = userLocation.location.coordinate
        if JZLocationManager.sharedManager.updateCoordinate(coor) {
            if isLogin {
                NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.UserLocationUpdated, object: nil)
            }
        }
    }
}
