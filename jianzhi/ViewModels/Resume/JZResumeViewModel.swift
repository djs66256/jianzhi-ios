//
//  JZResumeViewModel.swift
//  jianzhi
//
//  Created by daniel on 16/1/3.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZResumeViewModel: NSObject {
    static func create(resume:JZResume, _ success:()->Void, _ failure:(String?)->Void) {
        let params = Mapper().toJSON(resume)
        JZRequestOperationManager.POSTJSON("user/resume/create", params: params, success: {(json:NSDictionary) -> Void in
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
    
    static func edit(resume:JZResume, success:()->Void, failure:(String?)->Void) {
        var params = [String:String]()
        if resume.educationLevel != 0 {
            params["educationLevel"] = String(resume.educationLevel)
        }
        if resume.expectJob != nil {
            params["expectJob"] = resume.expectJob
        }
        if resume.descriptions != nil {
            params["description"] = resume.descriptions
        }
        
        if params.count == 0 {
            return success()
        }
        
        JZRequestOperationManager.POSTParams("user/resume/edit", params: params, success: { (json:NSDictionary) -> Void in
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
    
    static func myInfo(success:(JZResume)->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("user/resume/my/info", params: nil, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                let resume = Mapper<JZResume>().map(json["content"])
                if resume != nil {
                    success(resume!)
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
