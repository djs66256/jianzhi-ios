//
//  JZRequestFilter.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

protocol JZRequestFilterProtocol {
    func doFilter(url:NSURL?, _ json:NSDictionary) -> String?
}

class JZRequestFilter: NSObject, JZRequestFilterProtocol {
    static let sharedFilter = JZRequestFilter()
    private var filters = [JZRequestLoginFilter()]
    
    func doFilter(url:NSURL?, _ json:NSDictionary) -> String? {
        for filter in filters {
            if let error = filter.doFilter(url, json) {
                return error
            }
        }
        return nil
    }
}


class JZRequestLoginFilter: JZRequestFilterProtocol {
    func doFilter(url:NSURL?, _ json:NSDictionary) -> String? {
        if url == nil {
            return nil
        }
        let path = url!.path
        if path != nil && path!.hasPrefix("/json/user") {
            if (json["retCode"] as? Int == JZRequestResult.NeedLogin.rawValue) {
                NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.NeedLogin, object: nil)
                return "请先登录"
            }
        }
        
        return nil
    }
}