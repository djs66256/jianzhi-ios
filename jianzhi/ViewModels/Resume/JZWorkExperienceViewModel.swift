//
//  JZWorkExperienceViewModel.swift
//  jianzhi
//
//  Created by daniel on 16/1/14.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZWorkExperienceViewModel: NSObject {
    static func create(work:JZWorkExperience, success:(JZWorkExperience)->Void, failure:(String?)->Void) {
        if work.companyName == nil || work.companyName!.isEmpty {
            return failure("请填写公司名称")
        }
        if work.position == nil || work.position!.isEmpty {
            return failure("请填写职位名称")
        }
        if work.fromTime == nil {
            return failure("请选择开始时间")
        }
        if work.toTime == nil {
            return failure("请选择结束时间")
        }
        let params = Mapper().toJSON(work)
        JZRequestOperationManager.POSTJSON("user/resume/work/create", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                let work : JZWorkExperience? = Mapper<JZWorkExperience>().map(json["content"])
                if work != nil {
                    success(work!)
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
    
    static func edit(work:JZWorkExperience, success:()->Void, failure:(String?)->Void) {
        if work.companyName == nil || work.companyName!.isEmpty {
            return failure("公司名称为空")
        }
        if work.position == nil || work.position!.isEmpty {
            return failure("职位名称为空")
        }
        
        let params = Mapper().toJSON(work)
        JZRequestOperationManager.POSTJSON("user/resume/work/edit", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: { (error:String?) -> Void in
                failure(error)
        })
    }
    
    static func delete(wid:Int, success:()->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("user/resume/work/delete", params: ["id": wid], success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
}
