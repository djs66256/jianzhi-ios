//
//  JZJobEditableTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobEditableTableViewController: JZStaticTableViewController, JZSalaryTypePickerViewControllerDelegate {
    
    private var j = JZJob()
    
    var job : JZJob {
        get {
            j.title = jobTitleCell.textField?.text
            j.detail = descriptionCell.textView?.text
            j.salary = Int(wageCell.textField?.text ?? "0")
            return j
        }
        set {
            j = (newValue.copy() as? JZJob) ?? JZJob()
        }
    }
    
    @IBOutlet var jobTitleCell: JZTextFieldTableViewCell!
    @IBOutlet var wageCell: JZWageTableViewCell!
    @IBOutlet var descriptionCell: JZTextViewTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobTitleCell.textField?.text = j.title
        descriptionCell.textView?.text = j.detail
        wageCell.textField?.text = j.salary==nil ? "" : String(j.salary!)
        wageCell.button.setTitle(j.salaryType.nameValue(), forState: .Normal)
    }
    
    func salaryTypeSelected(viewController: JZSalaryTypePickerViewController, type: JZSalaryTypeBy) {
        j.salaryType = type
        wageCell.button.setTitle(type.nameValue(), forState: .Normal)
    }
    
    @IBAction func salaryTypeClicked(sender: AnyObject) {
        let viewController = JZSalaryTypePickerViewController()
        viewController.delegate = self
        viewController.showInController(self)
    }
    
}
