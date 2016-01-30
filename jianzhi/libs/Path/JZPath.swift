//
//  JZPath.swift
//  jianzhi
//
//  Created by daniel on 16/1/12.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZPath: NSObject {
    static let sharedPath = JZPath()
    
    let cache = {()->String in
        let cache = "\(NSHomeDirectory())/Cache"
        return cache
        }()
    
    class func userPath(file: String) -> String? {
        if let id = JZUserManager.sharedManager.currentUser?.uid {
            let user = "\(NSHomeDirectory())/Documents/user/\(id)/\(file)"
            if initPath(user) {
                return user
            }
        }
        return nil
    }
    
    func documents() -> String {
        return NSHomeDirectory()+"/Document"
    }
    
    class func initPath(path: String) -> Bool {
        guard NSFileManager.defaultManager().fileExistsAtPath(path) else {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
                return true
            }
            catch {
                return false
            }
        }
        return true
    }
}
