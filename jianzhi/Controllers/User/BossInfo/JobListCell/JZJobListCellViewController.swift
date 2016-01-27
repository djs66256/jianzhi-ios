//
//  JZJobListCellViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobListCellViewController: JZTableCellTableViewController, JZCreateJobViewControllerDelegate, JZEditJobViewControllerDelegate {
    
    let identifier = "cell"

    var jobList = [JZJob]()
    var editable = false {
        didSet {
            self.reloadData()
        }
    }
    
    let headerView = JZJobListHeaderView(frame: CGRectMake(0, 0, 100, 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.titleView.text = "职位列表"
        headerView.editButton.setTitle("add", forState: UIControlState.Normal)
        headerView.editButton.addTarget(self, action: Selector("addJobClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        headerView.editButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.tableView?.registerNib(UINib(nibName: "JZJobListCellTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - tableview delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count == 0 ? 1 : jobList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if jobList.count == 0 {
            let addIdentifier = "add"
            var cell = tableView.dequeueReusableCellWithIdentifier(addIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: addIdentifier)
                cell?.textLabel?.textAlignment = .Center
                cell?.textLabel?.text = "你还没有任何职位，马上添加"
            }
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! JZJobListCellTableViewCell
            
            cell.selectionStyle = editable ? .Default : .None
            cell.updateData(jobList[indexPath.row])
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.editButton.hidden = !editable
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        if jobList.count != 0 {
            let job = jobList[indexPath.row]
            let viewController = JZEditJobViewController(job)
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
        }
        else {
            addJobClicked()
        }
    }
    
    // MARK: - user event
    func addJobClicked() {
        let viewController = JZCreateJobViewController()
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - controller delegate
    func createJob(viewController: JZCreateJobViewController, _ job: JZJob) {
        viewController.navigationController?.popViewControllerAnimated(true)
        jobList.append(job)
    }
    
    func editJobFinished(viewController: JZEditJobViewController, job: JZJob) {
        for j in jobList {
            if j.id == job.id {
                j.mergeFrom(job)
                break
            }
        }
        
        viewController.navigationController?.popViewControllerAnimated(true)
    }

    func editJobDeleted(viewController: JZEditJobViewController, job: JZJob) {
        let index = jobList.indexOf { $0.id == job.id }
        if index != nil {
            jobList.removeAtIndex(index!)
        }
        viewController.navigationController?.popViewControllerAnimated(true)
    }
}
