//
//  JZRegisterDetailInfoTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/4.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZRegisterDetailInfoTableViewController: UITableViewController {
    
    static let cellIdentifier = "cell"
    
    var userInfo : JZUserInfo?
        
    @IBOutlet var nickNameCell: JZTextFieldTableViewCell!
    @IBOutlet var genderCell: JZGenderTableViewCell!
    @IBOutlet var buttonCell: UITableViewCell!
    
    var cellArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("nextStep"))
        self.navigationItem.title = "完善个人信息"
        
        cellArray = [["title":"选择头像"],["cell":nickNameCell],["cell":genderCell],["title":"城市"], ["cell": buttonCell]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let title = cellArray[indexPath.row]["title"] as? String {
            let cell = tableView.dequeueReusableCellWithIdentifier(JZRegisterDetailInfoTableViewController.cellIdentifier)
            ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: JZRegisterDetailInfoTableViewController.cellIdentifier)

            cell.textLabel?.text = title
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

            return cell
        }
        else {
            return cellArray[indexPath.row]["cell"] as! UITableViewCell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    @IBAction func nextStep() {
        JZUserViewModel.edit(nickNameCell.textField?.text, gender: genderCell.genderType, city: "", description: "", success: { () -> Void in
            if let boss = self.userInfo as? JZBossUserInfo {
                let viewController = JZRegisterCompanyTableViewController()
                viewController.userInfo = boss
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            else if let jobSeeker = self.userInfo as? JZJobseekerUserInfo {
                let viewController = JZRegisterResumeTableViewController()
                viewController.userInfo = jobSeeker
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            }, failure: { (error:String?) -> Void in
                JZAlertView.show(error)
        })
    }
    
}
