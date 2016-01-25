//
//  JZDateFormatter.swift
//  jianzhi
//
//  Created by daniel on 16/1/25.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZDateFormatter: NSObject {
    static let defaultFormatter = JZDateFormatter()
    
    let formatter = NSDateFormatter()
    
    func toString(date:NSDate, _ formatter:String) -> String {
        self.formatter.dateFormat = formatter
        return self.formatter.stringFromDate(date)
    }

}
