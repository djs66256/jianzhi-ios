//
//  JZCreateEducationTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/6.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZCreateEducationTableViewControllerDelegate : NSObjectProtocol {
    func createEducation(viewController:JZCreateEducationTableViewController, _ education:JZEducation)
}

class JZCreateEducationTableViewController: UIViewController {
    
    weak var delegate : JZCreateEducationTableViewControllerDelegate?
    
    let educationController = JZEducationEditableTableViewController()
    
    var education : JZEducation {
        get {
            return educationController.education
        }
        set {
            educationController.education = newValue
        }
    }
    @IBOutlet var tableFooterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(educationController.view)
        educationController.view.autoPinEdgesToSuperviewEdges()
        educationController.tableView.tableFooterView = tableFooterView
        addChildViewController(educationController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveClicked(sender: AnyObject) {
        JZEducationViewModel.create(education, success: { (education:JZEducation) -> Void in
            self.delegate?.createEducation(self, education)
            }, failure: { (error:String?) -> Void in
                JZAlertView.show(error)
        })
    }
    
}
