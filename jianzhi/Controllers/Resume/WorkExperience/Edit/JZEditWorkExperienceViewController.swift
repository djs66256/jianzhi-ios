//
//  JZEditWorkExperienceViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZEditWorkExperienceViewControllerDelegate : NSObjectProtocol {
    func editWorkExperienceFinished(viewController:JZEditWorkExperienceViewController, work:JZWorkExperience)
    func editWorkExperienceDeleted(viewController:JZEditWorkExperienceViewController, work:JZWorkExperience)
}

class JZEditWorkExperienceViewController: UIViewController {

    let workExpViewController = JZWorkExperienceEditableTableViewController()
    
    weak var delegate: JZEditWorkExperienceViewControllerDelegate?
    var workExperience : JZWorkExperience {
        get {
            return workExpViewController.work
        }
        set {
            workExpViewController.work = newValue
        }
    }
    
    @IBOutlet var tableFooterView: UIView!
    
    init(_ work: JZWorkExperience) {
        super.init(nibName: nil, bundle: nil)
        self.workExperience = work
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(workExpViewController.view)
        workExpViewController.view.autoPinEdgesToSuperviewEdges()
        workExpViewController.tableView.tableFooterView = tableFooterView
        addChildViewController(workExpViewController)
    }

    @IBAction func saveButtonClicked(sender: AnyObject) {
        JZWorkExperienceViewModel.edit(workExperience, success: { () -> Void in
            self.delegate?.editWorkExperienceFinished(self, work: self.workExperience)
            }, failure: {
                JZAlertView.show($0)
        })
    }
    
    @IBAction func deleteButtonClicked(sender: AnyObject) {
        if workExperience.id != nil && workExperience.id != 0 {
            JZWorkExperienceViewModel.delete(workExperience.id!, success: { () -> Void in
                self.delegate?.editWorkExperienceDeleted(self, work: self.workExperience)
                }, failure: {
                    JZAlertView.show($0)
            })
        }
    }
}
