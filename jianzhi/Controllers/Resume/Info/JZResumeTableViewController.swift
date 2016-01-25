//
//  JZResumeTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZResumeTableViewController: JZStaticTableViewController {
    
    var userInfo: JZJobseekerUserInfo?
    
    
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

        JZUserViewModel.myAllInfo({ (user:JZUserInfo) -> Void in
            if let jobseeker = user as? JZJobseekerUserInfo {
                self.userInfo = jobseeker
                self.educationController.educations = jobseeker.resume?.educations ?? [JZEducation]()
                self.workExperienceController.workExperiences = jobseeker.resume?.workExperiences ?? [JZWorkExperience]()
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

    func reloadData() {
        nameLabel.text = userInfo?.nickName
        genderLabel.text = userInfo?.gender?.nameValue()
        descriptionCell.textLabel?.text = userInfo?.resume?.descriptions ?? "这个人很懒，什么都没有留下"
        expectJobCell.textLabel?.text = userInfo?.resume?.expectJob
        
        educationController.reloadData()
        workExperienceController.reloadData()
        
        self.tableView.reloadData()
    }
    
}
