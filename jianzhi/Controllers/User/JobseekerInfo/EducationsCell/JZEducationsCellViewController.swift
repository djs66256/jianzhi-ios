//
//  JZEducationsCellViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/25.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZEducationsCellViewController: JZTableCellTableViewController, JZEditEducationViewControllerDelegate, JZCreateEducationTableViewControllerDelegate {
    
    let identifier = "edu"
    
    var editable = false {
        didSet {
            self.tableView?.reloadData()
        }
    }
    var educations = [JZEducation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.registerNib(UINib(nibName: "JZEducationCellTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        self.cell.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return educations.count==0 ? 1 : educations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if educations.count == 0 {
            let tipIdentifier = "tip"
            var cell = tableView.dequeueReusableCellWithIdentifier(tipIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: tipIdentifier)
                cell!.textLabel?.textAlignment = .Center
                cell!.textLabel?.text = "你还没有任何教育经验，马上去添加"
                cell!.accessoryType = .DisclosureIndicator
            }
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! JZEducationCellTableViewCell
            
            cell.selectionStyle = editable ? .Default : .None
            cell.updateData(educations[indexPath.row])
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = JZJobListHeaderView()
        view.titleView.text = "教育经历"
        view.editButton.addTarget(self, action: Selector("addEducationClicked"), forControlEvents: .TouchUpInside)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if editable {
            if educations.count == 0 {
                addEducationClicked()
            }
            else {
                let edu = educations[indexPath.row]
                let viewController = JZEditEducationViewController(edu)
                viewController.delegate = self
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func editEducationFinished(viewController: JZEditEducationViewController, education: JZEducation) {
        viewController.navigationController?.popViewControllerAnimated(true)
        
        for edu in educations {
            if edu.id == education.id {
                edu.mergeFrom(education)
                break
            }
        }
    }
    
    func editEducationDeleted(viewController: JZEditEducationViewController, education: JZEducation) {
        viewController.navigationController?.popViewControllerAnimated(true)
        let index = educations.indexOf { $0.id == education.id }
        if index != nil {
            educations.removeAtIndex(index!)
        }
    }
    
    func createEducation(viewController: JZCreateEducationTableViewController, _ education: JZEducation) {
        viewController.navigationController?.popViewControllerAnimated(true)
        educations.append(education)
    }

    func addEducationClicked() {
        let viewController = JZCreateEducationTableViewController()
        viewController.delegate = self
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
