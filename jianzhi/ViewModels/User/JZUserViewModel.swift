//
//  JZUserViewModel.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserViewModel: NSObject {
    
    class func getPhoneIdentifyingCode(phone:String?, success:(String)->Void, failure:(String?)->Void) {
        if phone == nil && phone!.isEmpty {
            return failure("请输入手机号")
        }
        let params = ["phone":phone!]
        JZRequestOperationManager.GETParams("json/phone/validate", params: params, success: { (json:NSDictionary) -> Void in
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
    
    class func register(userName:String?, password: String?, validate:String?, type:JZUserType, success:(JZUserInfo)->Void, failure:(String?)->Void) {
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
        JZRequestOperationManager.POSTParams("json/register", params: params, success: { (json:NSDictionary) -> Void in
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
    
    class func login(userName: String?, password: String?, success:(JZUserInfo)->Void, failure:(String?)->Void) {
        if userName == nil || userName!.isEmpty {
            return failure("请输入用户名")
        }
        if password == nil || password!.isEmpty {
            return failure("请输入密码")
        }
        
        let params = ["username":userName!, "password":password!]
        JZRequestOperationManager.POSTParams("json/login",
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
    
    class func changePassword(oldPassword: String, newPassword: String, newPassword2: String, success:()->Void, failure:(String?)->Void) {
        if oldPassword.isEmpty {
            return failure("请输入密码")
        }
        if newPassword.isEmpty {
            return failure("请输入新密码")
        }
        if newPassword2.isEmpty {
            return failure("请输入密码确认")
        }
        if newPassword2 != newPassword {
            return failure("输入密码不一致，请重新输入")
        }
        let params = ["oldPassword":oldPassword, "newPassword":newPassword, "newPassword2":newPassword2]
        JZRequestOperationManager.POSTParams("json/user/changePassword", params: params, success: { (json: NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    class func logout() {
        JZRequestOperationManager.POSTParams("logout", params: nil, success: { (json: NSDictionary?) -> Void in
            
            }, failure: nil)
    }
    
    class func editNickName(nickName:String?, success:()->Void, failure:(String?)->Void) {
        if nickName == nil || nickName!.isEmpty {
            return failure("请输入姓名")
        }
        JZRequestOperationManager.POSTParams("json/user/my/edit/nickname", params: ["nickname": nickName!], success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    class func editGender(gender:JZGenderType, success:()->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("json/user/my/edit/gender", params: ["gender": gender.rawValue], success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    class func editDescription(description:String?, success:()->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("json/user/my/edit/description", params: ["description": description ?? ""], success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    class func edit(nickName:String?, gender:JZGenderType, city:String?, description:String?, success:()->Void, failure:(String?)->Void) {
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
        params["description"] = description ?? ""
        
        JZRequestOperationManager.POSTParams("json/user/my/edit/info", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    class func forgetPasswor(userName:String?, password:String?, validate:String?, success:()->Void, failure:(String?)->Void) {
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
        
        JZRequestOperationManager.POSTParams("json/forgetPassword", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
//    class func myInfo(success:(JZUserInfo)->Void, failure:(String?)->Void) {
//        JZRequestOperationManager.POSTParams("user/my/info", params: nil, success: { (json:NSDictionary) -> Void in
//            if (json["retCode"] as? Int == JZRequestResult.Success.rawValue) {
//                let userInfo = Mapper<JZUserInfo>().map(json["content"])
//                if userInfo != nil {
//                    success(userInfo!)
//                }
//                else {
//                    failure("数据错误")
//                }
//            }
//            else {
//                failure(json["content"] as? String)
//            }
//            }, failure: failure)
//    }
    
    class func myAllInfo(success:(JZUserInfo)->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("json/user/my/allinfo", params: nil, success: { (json:NSDictionary) -> Void in
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
    
    class func userAllInfo(uid: Int, success:(JZUserInfo)->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("json/user/allinfo", params: ["uid": uid], success: { (json:NSDictionary) -> Void in
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
    
    class func userInfo(uid: Int, success:(JZUserInfo)->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("json/user/info", params: ["uid": uid], success: { (json:NSDictionary) -> Void in
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

    class func uploadHeadImage(image:UIImage, success:(String)->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTImage("json/user/upload/head", image: image, fileName: "head.jpg", success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                if let fileName = json["content"] as? String {
                    success(fileName)
                }
                else {
                    failure("上传失败")
                }
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    class func uploadCoordinate(coor: CLLocationCoordinate2D, success:()->Void, failure:(String?)->Void) {
        let params = ["lat": coor.latitude, "lon": coor.longitude]
        JZRequestOperationManager.POSTParams("json/user/upload/location", params: params, success: { (json) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure("更新失败")
            }

            }, failure: failure)
    }
}
