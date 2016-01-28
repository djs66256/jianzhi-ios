//
//  JZEducationViewModel.swift
//  jianzhi
//
//  Created by daniel on 16/1/14.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZEducationViewModel: NSObject {
    static func create(education:JZEducation, success:(JZEducation)->Void, failure:(String?)->Void) {
        if education.school==nil || education.school!.isEmpty {
            return failure("请填写学校")
        }
        if (education.major == nil || education.major!.isEmpty) {
            return failure("请填写专业")
        }
        if education.level == .none {
            return failure("请选择学历")
        }
        
        if education.fromTime == nil {
            return failure("请选择开始时间")
        }
        if education.toTime == nil {
            return failure("请选择结束时间")
        }
        
        let params = Mapper().toJSON(education)
        JZRequestOperationManager.POSTJSON("json/user/resume/education/create", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                let education = Mapper<JZEducation>().map(json["content"])
                if education != nil {
                    success(education!)
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
    
    static func edit(education:JZEducation, success:()->Void, failure:(String?)->Void) {
        if education.school==nil || education.school!.isEmpty {
            return failure("学校为空")
        }
        let params = Mapper().toJSON(education)
        JZRequestOperationManager.POSTJSON("json/user/resume/education/edit", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    static func delete(eid:Int, success:()->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("json/user/resume/education/delete", params: ["id": eid], success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
}
