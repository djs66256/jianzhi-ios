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
        JZRequestOperationManager.POSTJSON("json/user/search/job/filter", params: params, success: { (json:NSDictionary) -> Void in
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
        JZRequestOperationManager.POSTJSON("json/user/search/person/filter", params: params, success: { (json:NSDictionary) -> Void in
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
    
    class func mapSearch(type: String, coor: CLLocationCoordinate2D, range: Double, success:([JZMapAnnotation])->Void, failure:(String?)->Void) {
        let params = [
            "type": type,
            "lat": coor.latitude,
            "lon": coor.longitude,
            "range": range]
        JZRequestOperationManager.POSTParams("json/user/search/map", params: params, success: { (json) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                if let items = Mapper<JZMapAnnotation>().mapArray(json["content"]) {
                    success(items)
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
