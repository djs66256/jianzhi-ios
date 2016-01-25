//
//  JZDetialJobInfoViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/4.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZDetialJobInfoViewController: UIViewController {
    
    var jobId: Int?
    var job: JZJobDetailInfo?

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var salaryTypeLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyDescriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationItem.title = "工作内容"
        
        if jobId != nil {
            JZJobViewModel.info(jobId!, success: { (job:JZJobDetailInfo) -> Void in
                self.job = job
                self.reloadData()
                }, failure: { (error:String?) -> Void in
                    JZAlertView.show(error)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func postResume(sender: AnyObject) {
        UIAlertView(title: "投递成功", message: nil, delegate: nil, cancelButtonTitle: "确定").show()
    }
    
    func reloadData() {
        userNameLabel.text = job?.nickName
        jobNameLabel.text = job?.title
        jobDescriptionLabel.text = job?.detail
        salaryLabel.text = String(job!.salary!)
        salaryTypeLabel.text = job?.salaryType?.nameValue()
        companyNameLabel.text = job?.cname
        companyDescriptionLabel.text = job?.cdescription
        addressLabel.text = job?.address
    }

}
