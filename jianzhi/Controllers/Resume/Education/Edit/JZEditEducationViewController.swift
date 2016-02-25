//
//  JZEditEducationViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZEditEducationViewControllerDelegate {
    func editEducationFinished(viewController:JZEditEducationViewController, education:JZEducation)
    func editEducationDeleted(viewController:JZEditEducationViewController, education:JZEducation)
}

class JZEditEducationViewController: JZViewController {
    
    let educationViewController = JZEducationEditableTableViewController()
    
    var delegate: JZEditEducationViewControllerDelegate?
    
    var education : JZEducation {
        get {
            return educationViewController.education
        }
        set {
            educationViewController.education = newValue
        }
    }
    @IBOutlet var tableFooterView: UIView!
    
    init(_ edu: JZEducation) {
        super.init(nibName: nil, bundle: nil)
        self.education = edu
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(educationViewController.view)
        educationViewController.view.autoPinEdgesToSuperviewEdges()
        educationViewController.tableView.tableFooterView = tableFooterView
        addChildViewController(educationViewController)
    }
    
    @IBAction func saveButtonClicked(sender: AnyObject) {
        JZEducationViewModel.edit(education, success: {
            self.delegate?.editEducationFinished(self, education: self.education)
            }, failure: {
                JZAlertView.show($0)
        })
    }
    
    @IBAction func deleteButtonClicked(sender: AnyObject) {
        if education.id != nil && education.id != 0 {
        JZEducationViewModel.delete(education.id!, success: { () -> Void in
            self.delegate?.editEducationDeleted(self, education: self.education)
            }, failure: {
                JZAlertView.show($0)
        })
        }
    }
}
