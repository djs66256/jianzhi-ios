//
//  JZRegisterJobTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/4.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZRegisterJobTableViewController: UITableViewController, JZCreateJobViewControllerDelegate {
    
    let jobCellIdentifier = "job"
    
    var userInfo : JZBossUserInfo?
    
    @IBOutlet var addJobCell: UITableViewCell!
    @IBOutlet var saveButtonCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerNib(UINib(nibName: "JZRegisterJobTableViewCell", bundle: nil), forCellReuseIdentifier: jobCellIdentifier)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("nextStep"))
        self.navigationItem.title = "添加工作"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (userInfo?.jobList.count ?? 0) + 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < userInfo?.jobList.count ?? 0 {
            if let cell = tableView.dequeueReusableCellWithIdentifier(jobCellIdentifier) as? JZRegisterJobTableViewCell {
                cell.updateData(userInfo?.jobList[indexPath.row])
                return cell
            }
            else {
                return UITableViewCell()
            }
        }
        else if indexPath.row == userInfo?.jobList.count ?? 0 {
            return addJobCell
        }
        else {
            return saveButtonCell
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func nextStep() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addJobClicked(sender: AnyObject) {
        let viewController = JZCreateJobViewController()
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func createJob(viewController: JZCreateJobViewController, _ job: JZJob) {
        userInfo?.jobList.append(job)
        self.tableView.reloadData()
    }
    
}
