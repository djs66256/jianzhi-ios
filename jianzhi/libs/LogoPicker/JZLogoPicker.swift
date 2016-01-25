//
//  JZLogoPicker.swift
//  jianzhi
//
//  Created by daniel on 16/1/7.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZLogoPicker: NSObject, UIActionSheetDelegate {
    
    var sheet : UIActionSheet!
    
    override init() {
        super.init()
        
        sheet = UIActionSheet(title: "选择图片", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从相框中选择", "打开相机")
    }
    
    func showInController(viewController: UIViewController) {
        if viewController.tabBarController != nil {
            sheet.showFromTabBar(viewController.tabBarController!.tabBar)
        }
        else {
            sheet.showInView(viewController.view)
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1: NSLog("1")
        case 2: NSLog("2")
        default: NSLog("\(buttonIndex)")
        }
    }
}
