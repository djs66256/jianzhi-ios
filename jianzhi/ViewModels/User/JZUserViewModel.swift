//
//  JZUserViewModel.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserViewModel: NSObject {
    
    static func getPhoneIdentifyingCode(phone:String?, success:(String)->Void, failure:(String?)->Void) {
        let params = ["phone":phone!]
        JZRequestOperationManager.GETParams("phone/validate", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                if let validate = json["content"] as? String {
                    success(validate)
                }
                else {
                    failure("数据错误")
                }
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: { (error:String?) -> Void in
                failure(error)
        })
    }
    
    static func register(userName:String?, password: String?, validate:String?, type:JZUserType, success:(JZUserInfo)->Void, failure:(String?)->Void) {
        if userName == nil || userName!.isEmpty {
            failure("请输入用户名")
            return
        }
        if password == nil || password!.isEmpty {
            failure("请输入密码")
            return
        }
        if validate == nil || validate!.isEmpty {
            failure("请输入验证码")
            return
        }
        
        let group = (type==JZUserType.boss) ? "boss" : "jobseeker"
        let params = ["username": userName!, "password":password!, "validate":validate!, "group":group]
        JZRequestOperationManager.POSTParams("register", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                let userInfo : JZUserInfo? = Mapper<JZUserInfo>().map(json["content"])
                if userInfo == nil {
                    failure("数据错误")
                }
                else {
                    success(userInfo!)
                }
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: { (error:String?) -> Void in
                failure(error)
                })
    }
    
    static func login(userName: String?, password: String?, success:(JZUserInfo)->Void, failure:(String?)->Void) {
        if userName == nil || password == nil {
            failure("请输入用户名密码")
            return
        }
        
        let params = ["username":userName!, "password":password!]
        JZRequestOperationManager.POSTParams("login",
            params: params,
            success: { (json:NSDictionary) -> Void in
                if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                    let userInfo : JZUserInfo? = Mapper<JZUserInfo>().map(json["content"])
                    if userInfo == nil {
                        failure("数据错误")
                    }
                    else {
                        success(userInfo!)
                    }
                }
                else {
                    failure(json["content"] as? String)
                }
            },
            failure:{ (error:String?) -> Void in
                failure(error)
        })
    }
    
    static func changePassword(oldPassword: String, newPassword: String, newPassword2: String, success:()->Void, failure:(String?)->Void) {
        if newPassword2 != newPassword {
            failure("输入密码不一致，请重新输入")
        }
        let params = ["oldPassword":oldPassword, "newPassword":newPassword, "newPassword2":newPassword2]
        JZRequestOperationManager.POSTParams("user/changePassword", params: params, success: { (json: NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    static func logout() {
        JZRequestOperationManager.POSTParams("logout", params: nil, success: { (json: NSDictionary?) -> Void in
            
            }, failure: nil)
    }
    
    static func edit(nickName:String?, gender:JZGenderType, city:String?, success:()->Void, failure:(String?)->Void) {
        var params = [String:AnyObject]()
        if nickName != nil && !nickName!.isEmpty {
            params["nickName"] = nickName!
        }
        switch gender {
        case .male: params["gender"] = "m"
        case .female: params["gender"] = "f"
        default: params["gender"] = "u"
        }
        if city != nil && !city!.isEmpty {
            params["city"] = city
        }
        
        JZRequestOperationManager.POSTParams("user/edit", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    static func forgetPasswor(userName:String?, password:String?, validate:String?, success:()->Void, failure:(String?)->Void) {
        if userName == nil || userName!.isEmpty {
            failure("请输入用户名")
            return
        }
        if password == nil || password!.isEmpty {
            failure("请输入密码")
            return
        }
        if validate == nil || validate!.isEmpty {
            failure("请输入验证码")
            return
        }
        
        let params = ["username":userName!, "password":password!, "validate":validate!]
        
        JZRequestOperationManager.POSTParams("forgetPassword", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    static func myInfo(success:(JZUserInfo)->Void, failure:(String?)->Void) {
//        let params = ["uid": uid]
        JZRequestOperationManager.POSTParams("user/my/info", params: nil, success: { (json:NSDictionary) -> Void in
            if (json["retCode"] as? Int == JZRequestResult.Success.rawValue) {
                let userInfo = Mapper<JZUserInfo>().map(json["content"])
                if userInfo != nil {
                    success(userInfo!)
                }
                else {
                    failure("数据错误")
                }
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    static func myAllInfo(success:(JZUserInfo)->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("user/my/allinfo", params: nil, success: { (json:NSDictionary) -> Void in
            if (json["retCode"] as? Int == JZRequestResult.Success.rawValue) {
                let userInfo = Mapper<JZUserInfo>().map(json["content"])
                if userInfo != nil {
                    success(userInfo!)
                }
                else {
                    failure("数据错误")
                }
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }

}
