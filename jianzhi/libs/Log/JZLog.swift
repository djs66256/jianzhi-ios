//
//  JZLog.swift
//  jianzhi
//
//  Created by daniel on 16/1/12.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

#if DEBUG
    
    func JZLogInfo(items: Any...) {
        print("[info]\(items)")
    }
    
    func JZLogError(items: Any...) {
        print(items)
    }
    
#else
    
    func JZLogError(items: Any...) {
        print(items)
    }

#endif
