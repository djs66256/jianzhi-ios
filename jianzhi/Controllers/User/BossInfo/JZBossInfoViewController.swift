//
//  JZBossInfoViewController.swift
//  jianzhi
//
//  Created by daniel on 16/2/16.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZBossInfoViewController: JZViewController {

    let tableViewController = JZBossInfoTableViewController()
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    
    var userId: Int? {
        didSet {
            tableViewController.userId = userId
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .None
        
        view.addSubview(tableViewController.view)
        tableViewController.view.autoPinEdgeToSuperviewEdge(.Top)
        tableViewController.view.autoPinEdgeToSuperviewEdge(.Left)
        tableViewController.view.autoPinEdgeToSuperviewEdge(.Right)
        
        addChildViewController(tableViewController)
        
        if JZUserManager.sharedManager.currentUser?.userType == .boss {
            tableViewController.view.autoPinEdgeToSuperviewEdge(.Bottom)
            bottomView.hidden = true
        }
        else {
            tableViewController.view.autoPinEdge(.Bottom, toEdge: .Top, ofView: bottomView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func postResume(sender: AnyObject) {
        if let userId = userId {
            JZResumeViewModel.post(userId, success: {
                JZAlertView.show("投递成功")
                }, failure: {
                    JZAlertView.show($0)
            })
        }
    }
}
