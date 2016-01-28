//
//  JZSearchViewModel.swift
//  jianzhi
//
//  Created by daniel on 16/1/24.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSearchViewModel: NSObject {
    
    class func jobFilter(filter:JZJobFilter, success:([JZSearchJobItem]?)->Void, failure:(String?)->Void) {
        let params = Mapper().toJSON(filter)
        JZRequestOperationManager.POSTJSON("json/search/user/job/filter", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                if let item = Mapper<JZSearchJobItem>().mapArray(json["content"]) {
                    success(item)
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
    
    class func personFilter(filter:JZPersonFilter, success:([JZUserInfo])->Void, failure:(String?)->Void) {
        let params = filter.toJSON()
        JZRequestOperationManager.POSTJSON("json/search/user/person/filter", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                if let item = Mapper<JZUserInfo>().mapArray(json["content"]) {
                    success(item)
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
