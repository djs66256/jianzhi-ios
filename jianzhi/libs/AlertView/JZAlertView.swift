//
//  JZAlertView.swift
//  jianzhi
//
//  Created by daniel on 16/1/13.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZAlertView: NSObject {
    static func show(title: String?) {
        if title != nil && !title!.isEmpty {
            UIAlertView(title: title, message: nil, delegate: nil, cancelButtonTitle: "确定").show()
        }
    }
}
