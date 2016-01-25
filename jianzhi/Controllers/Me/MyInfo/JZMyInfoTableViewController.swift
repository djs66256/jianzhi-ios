//
//  JZMyInfoTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/25.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMyInfoTableViewController: JZStaticTableViewController {
    
    let identifier = "cell"
    
    var userInfo: JZUserInfo?
        
    @IBOutlet var educationController: JZEducationsCellViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        JZUserViewModel.myAllInfo({ (user:JZUserInfo) -> Void in
            self.userInfo = user
            if let jobseeker = user as? JZJobseekerUserInfo {
                self.educationController.educations = jobseeker.resume?.educations ?? [JZEducation]()
                
            }
            self.reloadData()
            }, failure: { (error:String?) -> Void in
                JZAlertView.show(error)
        })
        
        self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func reloadData() {
        educationController.reloadData()
        
        self.tableView.reloadData()
    }
    
    
}
