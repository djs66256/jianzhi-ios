//
//  JZSearchViewModel.swift
//  jianzhi
//
//  Created by daniel on 16/1/24.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSearchViewModel: NSObject {
    
    static func jobFilter(filter:JZJobFilter, success:([JZSearchJobItem]?)->Void, failure:(String?)->Void) {
        let params = Mapper().toJSON(filter)
        JZRequestOperationManager.POSTJSON("search/job/filter", params: params, success: { (json:NSDictionary) -> Void in
            if json["retCode"] as? Int == JZRequestResult.Success.rawValue {
                let item = Mapper<JZSearchJobItem>().mapArray(json["content"])
                success(item)
            }
            else {
                failure(json["content"] as? String)
            }
            }, failure: { (error:String?) -> Void in
                failure(error)
        })
    }
    
}
