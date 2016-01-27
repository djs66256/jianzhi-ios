//
//  JZRegisterResumeTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/4.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZRegisterResumeTableViewController: UITableViewController, JZCreateEducationTableViewControllerDelegate, JZCreateWorkExperienceTableViewControllerDelegate, JZEducationLevelPickerViewControllerDelegate{
    static let educationIdentifier = "education"
    static let workExperienceIdentifier = "work"
    
    var userInfo : JZJobseekerUserInfo!
    
    @IBOutlet var academicCell: UITableViewCell!
    @IBOutlet var expectJobCell: JZTextFieldTableViewCell!
    @IBOutlet var descriptionCell: JZTextViewTableViewCell!
    @IBOutlet var addEducationCell: UITableViewCell!
    @IBOutlet var addWorkExperienceCell: UITableViewCell!
    
    
    var cellArray = [UITableViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("nextStep"))
        self.navigationItem.title = "创建简历"
        
        
        if userInfo.resume == nil {
            userInfo.resume = JZResume()
        }
        if userInfo.resume?.educations == nil {
            userInfo.resume?.educations = []
        }
        if userInfo.resume?.workExperiences == nil {
            userInfo.resume?.workExperiences = []
        }
        
        self.tableView.registerNib(UINib(nibName: "JZEducationTableViewCell", bundle: nil), forCellReuseIdentifier: self.classForCoder.educationIdentifier)
        self.tableView.registerNib(UINib(nibName: "JZWorkExperienceTableViewCell", bundle: nil), forCellReuseIdentifier: self.classForCoder.workExperienceIdentifier)
        
        cellArray = [academicCell, expectJobCell, descriptionCell]
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
        return cellArray.count + 2
            + (userInfo.resume?.educations?.count ?? 0)
            + (userInfo.resume?.workExperiences?.count ?? 0)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell!
        if indexPath.row < cellArray.count {
            cell = cellArray[indexPath.row]
        }
        else if indexPath.row < cellArray.count + (userInfo.resume?.educations?.count ?? 0) {
            cell = tableView.dequeueReusableCellWithIdentifier(self.classForCoder.educationIdentifier)
            if let educationCell = cell as? JZEducationTableViewCell {
                let index = indexPath.row - cellArray.count
                let data = userInfo.resume?.educations?[index]
                educationCell.updateData(data)
            }
        }
        else if indexPath.row < cellArray.count + (userInfo.resume?.educations?.count ?? 0) + 1 {
            cell = addEducationCell
        }
        else if indexPath.row < cellArray.count + (userInfo.resume?.educations?.count ?? 0) + 1 + (userInfo.resume?.workExperiences?.count ?? 0) {
            cell = tableView.dequeueReusableCellWithIdentifier(self.classForCoder.workExperienceIdentifier)
            if let workCell = cell as? JZWorkExperienceTableViewCell {
                let index = indexPath.row - cellArray.count - 1 - (userInfo.resume?.educations?.count ?? 0)
                let data = userInfo.resume?.workExperiences?[index]
                workCell.updateData(data)
            }
        }
        else {
            cell = addWorkExperienceCell
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row < cellArray.count {
            return CGRectGetHeight(cellArray[indexPath.row].frame)
        }
        else if indexPath.row < cellArray.count + (userInfo.resume?.educations?.count ?? 0) {
            return 60
        }
        else if indexPath.row < cellArray.count + (userInfo.resume?.educations?.count ?? 0) + 1 {
            return CGRectGetHeight(addEducationCell.frame)
        }
        else if indexPath.row < cellArray.count + (userInfo.resume?.educations?.count ?? 0) + 1 + (userInfo.resume?.workExperiences?.count ?? 0) {
            return 60
        }
        else {
            return CGRectGetHeight(addWorkExperienceCell.frame)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0 {
            let viewController = JZEducationLevelPickerViewController()
            viewController.delegate = self
            viewController.showInController(self)
        }
        else if indexPath.row == cellArray.count + (userInfo.resume?.educations?.count ?? 0) {
            let viewController = JZCreateEducationTableViewController()
            viewController.delegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else if indexPath.row == cellArray.count + (userInfo.resume?.educations?.count ?? 0) + 1 + (userInfo.resume?.workExperiences?.count ?? 0) {
            let viewController = JZCreateWorkExperienceTableViewController()
            viewController.delegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func nextStep() {
        let description = descriptionCell.textView?.text
        if description != nil && !description!.isEmpty {
            userInfo.resume?.descriptions = description
        }
        
        let expectJob = expectJobCell.textField?.text
        if expectJob != nil && !expectJob!.isEmpty {
            userInfo.resume?.expectJob = expectJob
        }
        
        JZResumeViewModel.edit(userInfo.resume!, success: { () -> Void in
            }, failure: { (error:String?) -> Void in
        })
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - delegate
    func createEducation(viewController: JZCreateEducationTableViewController, _ education: JZEducation) {
        userInfo.resume?.educations?.append(education)
        self.tableView.reloadData()
    }
    
    func createWorkExperience(viewController: JZCreateWorkExperienceTableViewController, _ workExperience: JZWorkExperience) {
        viewController.navigationController?.popViewControllerAnimated(true)
        userInfo.resume?.workExperiences?.append(workExperience)
        self.tableView.reloadData()
    }
    
    func educationLevelSelected(controller: JZEducationLevelPickerViewController, level: JZEducationLevel) {
        userInfo.resume?.educationLevel = level.rawValue
        self.academicCell.detailTextLabel?.text = level.nameValue()
        self.tableView.reloadData()
    }
}
