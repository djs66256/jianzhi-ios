//
//  JZDetialJobInfoViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/4.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZDetialJobInfoViewController: JZViewController {
    
    var jobId: Int?
    var job: JZJobDetailInfo?

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var salaryTypeLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyDescriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationItem.title = "工作内容"
        
        if jobId != nil {
            JZJobViewModel.info(jobId!, success: { (job:JZJobDetailInfo) -> Void in
                self.job = job
                self.reloadData()
                }, failure: { (error:String?) -> Void in
                    JZAlertView.show(error)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func postResume(sender: AnyObject) {
        if let uid = job?.uid {
            JZUserService.instance.findUserById(uid, callback: { (user) -> Void in
                let group = JZMessageGroup()
                group.type = .Chat
                group.user = user
                if let curUser = JZUserManager.sharedManager.currentUser, let job = self.job?.toJobObject() {
                    JZMessageGroupService.instance.findGroupByGroup(group, callback: { (group) -> Void in
                        let message = JZMessage(fromUser: curUser, toUser: user, type: .Post, group: group)
                        message.job = job
                        message.unread = false
                        JZMessageManager.sharedManager.send(message, callback: { (success) -> Void in
                            if success {
                                JZAlertView.show("投递成功")
                            }
                            else {
                                JZAlertView.show("投递失败，请稍后再试")
                            }
                        })
                    })
                }
            })
            
        }
    }
    
    func reloadData() {
        userNameLabel.text = job?.nickName
        jobNameLabel.text = job?.title
        jobDescriptionLabel.text = job?.detail
        salaryLabel.text = String(job!.salary!)
        salaryTypeLabel.text = job?.salaryType?.nameValue()
        companyNameLabel.text = job?.cname
        companyDescriptionLabel.text = job?.cdescription
        addressLabel.text = job?.address
    }

}
