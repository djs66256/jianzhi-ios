//
//  JZBossInfoTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZBossInfoTableViewController: JZStaticTableViewController {
    
    var userInfo: JZBossUserInfo?
    var userId: Int?
    var editable = false
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet var companyCellController: JZCompanyCellViewController!
    @IBOutlet var jobListCellController: JZJobListCellViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(companyCellController)
        addChildViewController(jobListCellController)
        
        if userId == nil || userId == JZUserManager.sharedManager.currentUser?.uid {
            JZUserViewModel.myAllInfo({ (userInfo:JZUserInfo) -> Void in
                if let user = userInfo as? JZBossUserInfo {
                    self.editable = true
                    self.companyCellController.editable = true
                    self.jobListCellController.editable = true
                    
                    self.companyCellController.company = user.company
                    self.jobListCellController.jobList = user.jobList ?? [JZJob]()
                    
                    self.userInfo = user
                    self.reloadData()
                }
                }, failure: { JZAlertView.show($0) })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reloadData() {
        if let url = userInfo?.avatarUrl {
            headImageView.setImageWithURL(url, placeholderImage: nil)
        }
        nameLabel.text = userInfo?.nickName
        genderLabel.text = userInfo?.gender.nameValue()
        
        companyCellController.reloadData()
        jobListCellController.reloadData()
        self.tableView.reloadData()
    }
    
    @IBAction func userBaseInfoClicked(sender: AnyObject) {
        let viewController = JZEditUserBaseInfoTableViewController()
        viewController.userInfo = userInfo
        navigationController?.pushViewController(viewController, animated: true)
    }
}
