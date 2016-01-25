//
//  JZJsonRequestOperationManager.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZRequestResult : Int {
    case Success = 1, NeedLogin
}

class JZRequestOperationManager: NSObject {
    
    static let jsonBaseUrl = NSURL(string: "http://" + HTTP.location + "/json/")
    static let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    static let paramsManager = JZRequestOperationManager.buildParamsManager()
    static let jsonManager = JZRequestOperationManager.buildJsonManager()
    
    // json manager
    static func buildParamsManager() -> AFHTTPSessionManager {
        let manager = AFHTTPSessionManager(baseURL:JZRequestOperationManager.jsonBaseUrl, sessionConfiguration: sessionConfiguration)
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.requestSerializer.HTTPShouldHandleCookies = true
        manager.responseSerializer = AFJSONResponseSerializer()
        
        return manager
    }
    
    // json manager
    static func buildJsonManager() -> AFHTTPSessionManager {
        let manager = AFHTTPSessionManager(baseURL:JZRequestOperationManager.jsonBaseUrl, sessionConfiguration: sessionConfiguration)
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.HTTPShouldHandleCookies = true
        manager.responseSerializer = AFJSONResponseSerializer()
        
        return manager
    }
    
    static func POST(manager:AFHTTPSessionManager, urlString:String, params:AnyObject?, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        JZLogInfo("URL: " + urlString)
        
        manager.POST(urlString,
            parameters: params,
            progress: nil,
            success: { (task:NSURLSessionDataTask, data:AnyObject?) -> Void in
                if let json = data as? NSDictionary {
                    if let error = JZRequestFilter.sharedFilter.doFilter(task, json) {
                        failure?(error)
                    }
                    else {
                        success(json)
                    }
                }
                else {
                    failure?("数据格式错误")
                }
            },
            failure: {(task:NSURLSessionDataTask?, error:NSError) -> Void in
                #if DEBUG
                    failure?(error.description)
                #else
                    failure?("请求失败")
                #endif
            }
        )
    }
    
    static func GET(manager:AFHTTPSessionManager, urlString:String, params:AnyObject?, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        JZLogInfo("URL: " + urlString)
        manager.GET(urlString, parameters: params, progress: nil, success: { (task:NSURLSessionDataTask, data:AnyObject?) -> Void in
            if let json = data as? NSDictionary {
                if let error = JZRequestFilter.sharedFilter.doFilter(task, json) {
                    failure?(error)
                }
                else {
                    success(json)
                }
            }
            else {
                failure?("数据格式错误")
            }
            },
            failure: {(task:NSURLSessionDataTask?, error:NSError) -> Void in
                #if DEBUG
                    failure?(error.description)
                #else
                    failure?("请求失败")
                #endif
            }
        )
    }
    
    static func GETParams(urlString:String, params:AnyObject?, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        GET(paramsManager, urlString:urlString, params: params,
            success: success, failure: failure)
    }
    
    static func POSTParams(urlString:String, params:AnyObject?, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        POST(paramsManager, urlString:urlString, params: params,
            success: success, failure: failure)
    }
    
    static func POSTJSON(urlString:String, params:AnyObject?, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        POST(jsonManager, urlString:urlString, params: params,
            success: success, failure: failure)
    }
}
