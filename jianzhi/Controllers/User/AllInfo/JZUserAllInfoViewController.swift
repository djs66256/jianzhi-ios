//
//  JZUserAllInfoViewController.swift
//  jianzhi
//
//  Created by daniel on 16/2/22.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserAllInfoViewController: UIViewController {
    
    var userInfoViewController: UITableViewController? {
        didSet {
            if let userInfoViewController = userInfoViewController {
                addChildViewController(userInfoViewController)
                view.addSubview(userInfoViewController.view)
                userInfoViewController.view.autoPinEdgesToSuperviewEdges()
            }
        }
    }
    var userId: Int
    
    init(uid: Int) {
        userId = uid
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        JZUserViewModel.userAllInfo(userId, success: { (userInfo) -> Void in
            if let user = userInfo as? JZBossUserInfo {
                let bossController = JZBossInfoTableViewController()
                bossController.userId = user.uid
                bossController.userInfo = user
                self.userInfoViewController = bossController
            }
            else if let user = userInfo as? JZJobseekerUserInfo {
                let jobseekerController = JZJobSeekerTableViewController()
                jobseekerController.userId = user.uid
                jobseekerController.userInfo = user
                self.userInfoViewController = jobseekerController
            }
            }, failure: { JZAlertView.show($0) })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
