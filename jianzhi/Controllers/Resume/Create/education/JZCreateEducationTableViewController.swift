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

class JZCreateEducationTableViewController: JZStaticTableViewController, JZYearMonthPickerViewControllerDelegate, JZEducationLevelPickerViewControllerDelegate {
    
    weak var delegate : JZCreateEducationTableViewControllerDelegate?
    
    var education = JZEducation()

    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var majorTextField: UITextField!
    
    @IBOutlet var educationLevelCell: UITableViewCell!
    @IBOutlet var startTimeCell: UITableViewCell!
    @IBOutlet var endTimeCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - year month picker
    
    func yearMonthPicker(controller: JZYearMonthPickerViewController, _ date: NSDate?, _ year: Int, _ month: Int) {
        if controller.tagString == "start" {
            self.startTimeCell.detailTextLabel?.text = "\(year)年\(month)月"
            self.tableView.reloadData()
            education.fromTime = date
        }
        else if controller.tagString == "end" {
            self.endTimeCell.detailTextLabel?.text = "\(year)年\(month)月"
            self.tableView.reloadData()
            education.toTime = date
        }
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

    @IBAction func saveClicked(sender: AnyObject) {
        education.school = schoolTextField.text
        education.major = majorTextField.text
        
        JZEducationViewModel.create(education, success: { (education:JZEducation) -> Void in
            self.delegate?.createEducation(self, education)
            self.navigationController?.popViewControllerAnimated(true)
            }, failure: { (error:String?) -> Void in
                JZAlertView.show(error)
        })
    }
    
}
