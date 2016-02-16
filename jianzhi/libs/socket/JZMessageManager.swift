//
//  JZMessageManager.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageManager: UIView {
    static let sharedManager = JZMessageManager()

    func parse(data: String) {
        if let data = data.dataUsingEncoding(NSUTF8StringEncoding) {
        if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) {
            if let json = json as? [String: AnyObject] {
//                let type = Int(json["type"])
            }
        }
        }
    }

}
