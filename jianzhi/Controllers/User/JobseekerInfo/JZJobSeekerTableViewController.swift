//
//  JZMyJobSeekerTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobSeekerTableViewController: JZStaticTableViewController {
    
    var userId: Int?
    
    var userInfo: JZJobseekerUserInfo?
    
    var editable = false
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet var descriptionCell: UITableViewCell!
    @IBOutlet var expectJobCell: UITableViewCell!
    
    @IBOutlet var educationController: JZEducationsCellViewController!
    @IBOutlet var workExperienceController: JZWorkExperiencesCellViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChildViewController(educationController)
        self.addChildViewController(workExperienceController)
        
        if let user = userInfo {
            reloadWithUser(user)
        }
        else {
        if userId == nil || userId == JZUserManager.sharedManager.currentUser?.uid {
            JZUserViewModel.myAllInfo({ (user:JZUserInfo) -> Void in
                if let jobseeker = user as? JZJobseekerUserInfo {
                    self.reloadWithUser(jobseeker)
                }
                }, failure: { (error:String?) -> Void in
                    JZAlertView.show(error)
            })
        }
        else {
            JZUserViewModel.userAllInfo(userId!, success: { (userInfo) -> Void in
                if let user = userInfo as? JZJobseekerUserInfo {
                    self.reloadWithUser(user)
                }
                }, failure: { JZAlertView.show($0) })
            }
        }
        
        self.reloadData()
    }
    
    private func reloadWithUser(user: JZJobseekerUserInfo) {
        if user.uid == JZUserManager.sharedManager.currentUser?.uid {
            educationController.editable = true
            workExperienceController.editable = true
            editable = true
        }
        userInfo = user
        educationController.educations = user.resume?.educations ?? [JZEducation]()
        workExperienceController.workExperiences = user.resume?.workExperiences ?? [JZWorkExperience]()
        reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if editable && indexPath.row == 0 {
            let viewController = JZEditUserBaseInfoTableViewController()
            viewController.userInfo = userInfo
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func reloadData() {
        if let url = userInfo?.avatarUrl {
            headImageView.setImageWithURL(url, placeholderImage: nil)
        }
        nameLabel.text = userInfo?.nickName
        genderLabel.text = userInfo?.gender.nameValue()
        descriptionCell.textLabel?.text = userInfo?.descriptions ?? "这个人很懒，什么都没有留下"
        expectJobCell.textLabel?.text = userInfo?.resume?.expectJob
        
        educationController.reloadData()
        workExperienceController.reloadData()
        
        self.tableView.reloadData()
    }
}
