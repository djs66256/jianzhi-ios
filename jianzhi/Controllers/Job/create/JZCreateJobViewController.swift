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

class JZCreateJobViewController: JZViewController {

    weak var delegate : JZCreateJobViewControllerDelegate?
    
    let jobViewController = JZJobEditableTableViewController()
    
    var job : JZJob {
        get {
            return jobViewController.job
        }
    }
    
    @IBOutlet var tableFooterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(jobViewController.view)
        jobViewController.view.autoPinEdgesToSuperviewEdges()
        jobViewController.tableView.tableFooterView = tableFooterView
        addChildViewController(jobViewController)
    }
    
    @IBAction func saveButtonClicked(sender: AnyObject) {
        JZJobViewModel.create(job, success: { (job:JZJob) -> Void in
            self.delegate?.createJob(self, job)
            self.navigationController?.popViewControllerAnimated(true)
            }, failure: { (error:String?) -> Void in
                JZAlertView.show(error)
        })
    }
}
