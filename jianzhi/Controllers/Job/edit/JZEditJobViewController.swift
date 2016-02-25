//
//  JZEditJobViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZEditJobViewControllerDelegate : NSObjectProtocol {
    func editJobFinished(viewController:JZEditJobViewController, job:JZJob)
    func editJobDeleted(viewController:JZEditJobViewController, job:JZJob)
}

class JZEditJobViewController: JZViewController {
    
    let jobViewController = JZJobEditableTableViewController()

    weak var delegate: JZEditJobViewControllerDelegate?
    
    var job: JZJob {
        get {
            return jobViewController.job
        }
        set {
            jobViewController.job = newValue ?? JZJob()
        }
    }
    
    @IBOutlet var tableFooterView: UIView!
    
    init(_ job: JZJob) {
        super.init(nibName: nil, bundle: nil)
        self.job = job
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(jobViewController.view)
        jobViewController.tableView.tableFooterView = tableFooterView
        jobViewController.view.autoPinEdgesToSuperviewEdges()
        addChildViewController(jobViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveButtonClicked(sender: AnyObject) {
        JZJobViewModel.edit(job, success: { () -> Void in
            self.delegate?.editJobFinished(self, job: self.job)
            }, failure: {
                JZAlertView.show($0)
        })
        
    }
    
    @IBAction func deleteButtonClicked(sender: AnyObject) {
        if job.id != nil && job.id != 0 {
            JZJobViewModel.delete(job.id!, success: { () -> Void in
                self.delegate?.editJobDeleted(self, job: self.job)
                }, failure: {
                    JZAlertView.show($0)
            })
        }
    }

}
