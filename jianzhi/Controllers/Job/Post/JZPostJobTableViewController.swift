//
//  JZPostJobTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/2/16.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZPostJobTableViewController: JZStaticTableViewController, JZSelectMyJobTableViewControllerDelegate {
        
    @IBOutlet var jobCell: UITableViewCell!
    @IBOutlet var descriptionCell: JZTextViewTableViewCell!
    
    var job: JZJob?
    var userInfo: JZUserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell == jobCell {
            let controller = JZSelectMyJobTableViewController()
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    @IBAction func postJob(sender: AnyObject) {
        if let currentUser = JZUserManager.sharedManager.currentUser, let toUser = userInfo, let job = job {
            let group = JZMessageGroup()
            group.type = .Chat
            group.user = toUser
            
            JZMessageGroupService.instance.findGroupByGroup(group, callback: { (group) -> Void in
                let message = JZMessage(fromUser: currentUser, toUser: toUser, type: .Job, group: group)
                message.unread = false
                message.job = job
                message.text = self.descriptionCell.textView?.text
                
                JZMessageManager.sharedManager.send(message, callback: { (success) -> Void in
                    if success {
                        JZAlertView.show("投递成功")
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                    else {
                        JZAlertView.show("投递成功")
                    }
                })
            })
        }
    }
    
    func didSelectJob(controller: JZSelectMyJobTableViewController, job: JZJob) {
        self.job = job
        jobCell.detailTextLabel?.text = job.title
        controller.navigationController?.popViewControllerAnimated(true)
    }
}
