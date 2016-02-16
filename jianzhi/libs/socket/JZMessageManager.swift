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
        if let json = try? NSJSONSerialization.JSONObjectWithData(data.dataUsingEncoding(NSUTF8StringEncoding), options: 0) {
            if let json = json as? [String: AnyObject] {
                let type = Int(json["type"])
            }
        }
    }

}
