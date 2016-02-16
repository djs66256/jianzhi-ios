//
//  JZWorkExperiencesCellViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZWorkExperiencesCellViewController: JZTableCellTableViewController, JZCreateWorkExperienceTableViewControllerDelegate, JZEditWorkExperienceViewControllerDelegate {
    
    let identifier = "cell"

    var editable = false {
        didSet {
            self.tableView?.reloadData()
        }
    }
    var workExperiences = [JZWorkExperience]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView?.registerNib(UINib(nibName: "JZWorkExperiencesCellTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workExperiences.count==0 ? 1 : workExperiences.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if workExperiences.count == 0 {
            let tipIdentifier = "tip"
            var cell = tableView.dequeueReusableCellWithIdentifier(tipIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: tipIdentifier)
                cell!.textLabel?.textAlignment = .Center
            }
            if editable {
                cell!.textLabel?.text = "你还没有任何工作经验，马上去添加"
                cell!.accessoryType = .DisclosureIndicator
                cell!.selectionStyle = .Default
            }
            else {
                cell!.textLabel?.text = "没有工作经验"
                cell!.accessoryType = .None
                cell!.selectionStyle = .None
            }
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! JZWorkExperiencesCellTableViewCell
            
            cell.updateData(workExperiences[indexPath.row])
            cell.selectionStyle = editable ? .Default : .None
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if editable {
            if workExperiences.count == 0 {
                addWorkExperienceClicked()
            }
            else {
                let work = workExperiences[indexPath.row]
                let viewController = JZEditWorkExperienceViewController(work)
                viewController.delegate = self
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = JZJobListHeaderView()
        view.titleView.text = "工作经历"
        view.editButton.addTarget(self, action: Selector("addWorkExperienceClicked"), forControlEvents: .TouchUpInside)
        view.editButton.setTitle("add", forState: .Normal)
        view.editButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        view.editButton.hidden = !editable
        return view
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func createWorkExperience(viewController: JZCreateWorkExperienceTableViewController, _ workExperience: JZWorkExperience) {
        viewController.navigationController?.popViewControllerAnimated(true)
        workExperiences.append(workExperience)
    }
    
    func editWorkExperienceFinished(viewController: JZEditWorkExperienceViewController, work: JZWorkExperience) {
        viewController.navigationController?.popViewControllerAnimated(true)
        for w in workExperiences {
            if w.id == work.id {
                w.mergeFrom(work)
                break
            }
        }
    }
    
    func editWorkExperienceDeleted(viewController: JZEditWorkExperienceViewController, work: JZWorkExperience) {
        viewController.navigationController?.popViewControllerAnimated(true)
        let index = workExperiences.indexOf { $0.id == work.id }
        if index != nil {
            workExperiences.removeAtIndex(index!)
        }
    }

    func addWorkExperienceClicked() {
        let viewController = JZCreateWorkExperienceTableViewController()
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}
