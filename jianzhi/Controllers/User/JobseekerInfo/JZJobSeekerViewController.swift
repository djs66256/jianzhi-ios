//
//  JZJobSeekerViewController.swift
//  jianzhi
//
//  Created by daniel on 16/2/16.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobSeekerViewController: JZViewController {
    let tableViewController = JZJobSeekerTableViewController()
    
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
        
        if JZUserManager.sharedManager.currentUser?.userType == .jobseeker {
            tableViewController.view.autoPinEdgeToSuperviewEdge(.Bottom)
            bottomView.hidden = true
        }
        else {
            tableViewController.view.autoPinEdge(.Bottom, toEdge: .Top, ofView: bottomView)
        }
    }

    @IBAction func postJob(sender: AnyObject) {
        if let user = tableViewController.userInfo {
            let controller = JZPostJobTableViewController()
            controller.userInfo = user
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
