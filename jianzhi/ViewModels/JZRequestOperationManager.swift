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
    
    static let jsonBaseUrlString = "http://" + HTTP.location + "/"
    static let jsonBaseUrl = NSURL(string: JZRequestOperationManager.jsonBaseUrlString)
    static let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    static let paramsManager = JZRequestOperationManager.buildParamsManager()
    static let jsonManager = JZRequestOperationManager.buildJsonManager()
    
    // json manager
    private class func buildParamsManager() -> AFHTTPSessionManager {
        let manager = AFHTTPSessionManager(baseURL:JZRequestOperationManager.jsonBaseUrl, sessionConfiguration: sessionConfiguration)
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.requestSerializer.HTTPShouldHandleCookies = true
        manager.responseSerializer = AFJSONResponseSerializer()
        
        return manager
    }
    
    // json manager
    private class func buildJsonManager() -> AFHTTPSessionManager {
        let manager = AFHTTPSessionManager(baseURL:JZRequestOperationManager.jsonBaseUrl, sessionConfiguration: sessionConfiguration)
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.HTTPShouldHandleCookies = true
        manager.responseSerializer = AFJSONResponseSerializer()
        
        return manager
    }
    
    private class func POST(manager:AFHTTPSessionManager, urlString:String, params:AnyObject?, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        JZLogInfo("URL: " + urlString)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        manager.POST(urlString,
            parameters: params,
            progress: nil,
            success: { (task:NSURLSessionDataTask, data:AnyObject?) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if let json = data as? NSDictionary {
                    if let error = JZRequestFilter.sharedFilter.doFilter(task.originalRequest?.URL, json) {
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
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                #if DEBUG
                    failure?(error.localizedDescription)
                #else
                    failure?("请求失败")
                #endif
            }
        )
    }
    
    private class func GET(manager:AFHTTPSessionManager, urlString:String, params:AnyObject?, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        JZLogInfo("URL: " + urlString)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        manager.GET(urlString, parameters: params, progress: nil, success: { (task:NSURLSessionDataTask, data:AnyObject?) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if let json = data as? NSDictionary {
                if let error = JZRequestFilter.sharedFilter.doFilter(task.originalRequest?.URL, json) {
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
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                #if DEBUG
                    failure?(error.localizedDescription)
                #else
                    failure?("请求失败")
                #endif
            }
        )
    }
    
    class func GETParams(urlString:String, params:AnyObject?, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        GET(paramsManager, urlString:urlString, params: params,
            success: success, failure: failure)
    }
    
    class func POSTParams(urlString:String, params:AnyObject?, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        POST(paramsManager, urlString:urlString, params: params,
            success: success, failure: failure)
    }
    
    class func POSTJSON(urlString:String, params:AnyObject?, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        POST(jsonManager, urlString:urlString, params: params,
            success: success, failure: failure)
    }
    
    class func POSTImage(urlString:String, image:UIImage, fileName:String, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        let data = UIImageJPEGRepresentation(image, 0)
        if data == nil {
            failure?("图片格式错误")
            return
        }
        
        POSTFile(urlString, data: data!, filename: fileName, mimeType: "image/jpeg", success: success, failure: failure)
    }
    
    class func POSTFile(urlString:String, data:NSData, filename:String, mimeType:String, success:(NSDictionary)->Void, failure:((String?)->Void)?) {
        JZLogInfo("URL: " + urlString)
        
        let urlStr = jsonBaseUrlString + urlString
        let request = paramsManager.requestSerializer.multipartFormRequestWithMethod("POST", URLString: urlStr, parameters: nil, constructingBodyWithBlock: { (formData:AFMultipartFormData) -> Void in
                formData.appendPartWithFileData(data, name: "file", fileName: filename, mimeType: mimeType)
            }, error: nil)
        let task = paramsManager.uploadTaskWithStreamedRequest(request, progress: nil) { (response:NSURLResponse, data:AnyObject?, error:NSError?) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if error == nil {
                if let json = data as? NSDictionary {
                    if let error = JZRequestFilter.sharedFilter.doFilter(response.URL, json) {
                        failure?(error)
                    }
                    else {
                        success(json)
                    }
                }
                else {
                    failure?("数据格式错误")
                }
                
            }
            else {
                #if DEBUG
                    failure?(error?.localizedDescription)
                #else
                    failure?("请求失败")
                #endif
            }
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        task.resume()
    }
}
