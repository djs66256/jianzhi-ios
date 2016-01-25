//
//  JZPath.swift
//  jianzhi
//
//  Created by daniel on 16/1/12.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZPath: NSObject {
    let cache = {()->String in
        let cache = "\(NSHomeDirectory())/Cache"
        return cache
        }()
    
    let user = {()->String in
        let user = "\(NSHomeDirectory())/Documents"
        return user
    }()
    
    static func documents() -> String {
        return NSHomeDirectory()+"/Document"
    }
    
    static func initPath(path: String) {
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                
            }
        }
    }
}
