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
    
    class func mapSearch(success:([JZMapAnnotation])->Void, failure:(String?)->Void) {
        
        var annotations = [JZMapAnnotation]()
        for i in 0...3 {
            let annotation = JZPersonMapAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(39.915 + 0.04 * Double(i), 116.404 + 0.04 * Double(i))
            annotation.title = "person"
            annotation.subtitle = "person description"
            
            annotations.append(annotation)
        }
        
        for i in 0...3 {
            let annotation = JZCompanyMapAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(39.905 - 0.04 * Double(i), 116.404 + 0.04 * Double(i))
            annotation.title = "company"
            annotation.subtitle = "company detail"
            
            annotations.append(annotation)
        }
        
        success(annotations)
        
    }
}
