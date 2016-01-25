//
//  JZCompanyViewModel.swift
//  jianzhi
//
//  Created by daniel on 16/1/14.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZCompanyViewModel: NSObject {

    static func edit(company:JZCompany, success:()->Void, failure:(String?)->Void) {
        if company.name == nil || company.name!.isEmpty {
            return failure("公司名称为空")
        }
        if company.descriptions == nil || company.descriptions!.isEmpty {
            return failure("公司详情为空")
        }
        
        let params = Mapper().toJSON(company)
        JZRequestOperationManager.POSTJSON("user/company/edit", params: params, success: { (json:NSDictionary) -> Void in
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
    
    static func myInfo(success:(JZCompany)->Void, failure:(String?)->Void) {
        JZRequestOperationManager.POSTParams("user/company/my/info", params: nil, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                let company = Mapper<JZCompany>().map(json["content"])
                if company != nil {
                    success(company!)
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
