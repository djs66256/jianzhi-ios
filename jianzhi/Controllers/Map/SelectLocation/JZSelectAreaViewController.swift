//
//  JZSelectAreaViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZSelectAreaViewControllerDelegate : NSObjectProtocol {
    func selectArea(code: Int, area:String)
}

class JZSelectAreaViewController: JZAlertViewController, JZSelectAreaViewControllerDelegate {
    
    var delegate: JZSelectAreaViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = JZSelectProvinceTableViewController()
        viewController.delegate = self
        let navi = UINavigationController(rootViewController: viewController)
        self.addChildViewController(navi)
        self.view.addSubview(navi.view)
        
        navi.navigationBarHidden = true
        navi.view.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectArea(code: Int, area: String) {
        delegate?.selectArea(code, area: area)
        dismiss()
    }
}
