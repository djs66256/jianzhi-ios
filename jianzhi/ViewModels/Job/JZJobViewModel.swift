//
//  JZJobViewModel.swift
//  jianzhi
//
//  Created by daniel on 16/1/14.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobViewModel: NSObject {

    static func create(job:JZJob, success:(JZJob)->Void, failure:(String?)->Void) {
        if job.title == nil || job.title!.isEmpty {
            return failure("请输入职位名称")
        }
        if job.detail == nil || job.detail!.isEmpty {
            return failure("请输入职位详情")
        }
        
        let params = Mapper().toJSON(job)
        JZRequestOperationManager.POSTJSON("json/user/job/create", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                let job : JZJob? = Mapper<JZJob>().map(json["content"])
                if job != nil {
                    success(job!)
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
    
    static func edit(job:JZJob, success:()->Void, failure:(String?)->Void) {
        if job.title == nil || job.title!.isEmpty {
            return failure("请输入职位名称")
        }
        if job.detail == nil || job.detail!.isEmpty {
            return failure("请输入职位详情")
        }
        
        let params = Mapper().toJSON(job)
        JZRequestOperationManager.POSTJSON("json/user/job/edit", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    static func delete(jobId:Int, success:()->Void, failure:(String?)->Void) {
        let params = ["id": jobId]
        JZRequestOperationManager.POSTParams("json/user/job/delete", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                success()
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
    
    static func info(jobId:Int, success:(JZJobDetailInfo)->Void, failure:(String?)->Void) {
        let params = ["id": jobId]
        JZRequestOperationManager.POSTParams("json/user/job/info", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                let job : JZJobDetailInfo? = Mapper<JZJobDetailInfo>().map(json["content"])
                if job != nil {
                    success(job!)
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
    
    static func myInfo(success:([JZJob])->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("json/user/job/my/info", params: nil, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                let jobs = Mapper<JZJob>().mapArray(json["content"])
                success(jobs ?? [JZJob]())
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: failure)
    }
}
