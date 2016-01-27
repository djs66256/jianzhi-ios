//
//  JZEducationEditableTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZEducationEditableTableViewController: JZStaticTableViewController, JZYearMonthPickerViewControllerDelegate, JZEducationLevelPickerViewControllerDelegate {
    
    private var edu = JZEducation()
    var education : JZEducation {
        get {
            edu.school = schoolTextField.text
            edu.major = majorTextField.text
            return edu
        }
        set {
            edu = JZEducation(newValue)
        }
    }
    
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var majorTextField: UITextField!
    
    @IBOutlet var educationLevelCell: UITableViewCell!
    @IBOutlet var startTimeCell: UITableViewCell!
    @IBOutlet var endTimeCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - year month picker
    
    func yearMonthPicker(controller: JZYearMonthPickerViewController, _ date: NSDate?, _ year: Int, _ month: Int) {
        if controller.tagString == "start" {
            education.fromTime = date
        }
        else if controller.tagString == "end" {
            education.toTime = date
        }
        reloadData()
    }
    
    func educationLevelSelected(controller: JZEducationLevelPickerViewController, level: JZEducationLevel) {
        education.level = level
        educationLevelCell.detailTextLabel?.text = level.nameValue()
        self.tableView.reloadData()
    }
    
    // MARK: - table view
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = cellArray[indexPath.row]
        if cell == startTimeCell || cell == endTimeCell {
            let viewController = JZYearMonthPickerViewController()
            viewController.delegate = self
            viewController.tagString = (startTimeCell == cell) ? "start" : "end"
            viewController.showInController(self)
        }
        else if cell == educationLevelCell {
            let viewController = JZEducationLevelPickerViewController()
            viewController.delegate = self
            viewController.showInController(self)
        }
    }
    
    func reloadData() {
        schoolTextField.text = edu.school
        majorTextField.text = edu.major
        educationLevelCell.detailTextLabel?.text = edu.level.nameValue()
        if edu.fromTime != nil {
            startTimeCell.detailTextLabel?.text = JZDateFormatter.defaultFormatter.toString(edu.fromTime!, "yyyy年MM月")
        }
        else {
            startTimeCell.detailTextLabel?.text = ""
        }
        if edu.toTime != nil {
            endTimeCell.detailTextLabel?.text = JZDateFormatter.defaultFormatter.toString(edu.toTime!, "yyyy年MM月")
        }
        else {
            endTimeCell.detailTextLabel?.text = ""
        }
        
        self.tableView.reloadData()
    }
}
