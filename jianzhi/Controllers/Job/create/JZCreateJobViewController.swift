//
//  JZCreateJobViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/7.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZCreateJobViewControllerDelegate : NSObjectProtocol {
    func createJob(viewController: JZCreateJobViewController, _ job: JZJob)
}

class JZCreateJobViewController: JZStaticTableViewController, JZSalaryTypePickerViewControllerDelegate {

    weak var delegate : JZCreateJobViewControllerDelegate?
    
    @IBOutlet var jobTitleCell: JZTextFieldTableViewCell!
    @IBOutlet var wageCell: JZWageTableViewCell!
    @IBOutlet var descriptionCell: JZTextViewTableViewCell!
    
    var job = JZJob()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func salaryTypeSelected(viewController: JZSalaryTypePickerViewController, type: JZSalaryTypeBy) {
        job.salaryType = type
    }

    @IBAction func salaryTypeClicked(sender: AnyObject) {
        let viewController = JZSalaryTypePickerViewController()
        viewController.delegate = self
        viewController.showInController(self)
    }

    @IBAction func saveButtonClicked(sender: AnyObject) {
        job.title = jobTitleCell.textField?.text
        job.detail = descriptionCell.textView?.text
        job.salary = Int(wageCell.textField?.text ?? "0")
        
        JZJobViewModel.create(job, success: { (job:JZJob) -> Void in
            self.delegate?.createJob(self, job)
            self.navigationController?.popViewControllerAnimated(true)
            }, failure: { (error:String?) -> Void in
                JZAlertView.show(error)
        })
    }
}
