//
//  JZServerDateTransforms.swift
//  jianzhi
//
//  Created by daniel on 16/1/27.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

public class JZServerDateTransforms: TransformType {
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let timeInt = value as? Double {
            return NSDate(timeIntervalSince1970: NSTimeInterval(timeInt / 1000))
        }
        
        if let timeStr = value as? String {
            return NSDate(timeIntervalSince1970: NSTimeInterval(atof(timeStr) / 1000))
        }
        
        return nil
    }
    
    public func transformToJSON(value: NSDate?) -> Double? {
        if let date = value {
            return Double(date.timeIntervalSince1970) * 1000
        }
        return nil
    }
}
