//
//  JZWorkExperienceEditableTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZWorkExperienceEditableTableViewController: JZStaticTableViewController, JZYearMonthPickerViewControllerDelegate {
    
    private var pwork = JZWorkExperience()
    var work : JZWorkExperience {
        get {
            pwork.companyName = companyNameTextField.text
            pwork.descriptions = descriptionTextView.text
            pwork.position = positionTextField.text
            return pwork
        }
        set {
            pwork = JZWorkExperience(newValue)
        }
    }
    
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var companyNameTextField: UITextField!
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
    
    func yearMonthPicker(controller: JZYearMonthPickerViewController, _ date: NSDate?, _ year: Int, _ month: Int) {
        if controller.tagString == "start" {
            self.startTimeCell.detailTextLabel?.text = "\(year)年\(month)月"
            self.tableView.reloadData()
            work.fromTime = date
        }
        else if controller.tagString == "end" {
            self.endTimeCell.detailTextLabel?.text = "\(year)年\(month)月"
            self.tableView.reloadData()
            work.toTime = date
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = cellAtIndexPath(indexPath)
        if cell == startTimeCell || cell == endTimeCell {
            let viewController = JZYearMonthPickerViewController()
            viewController.delegate = self
            viewController.tagString = (cell == startTimeCell) ? "start" : "end"
            
            viewController.showInController(self)
        }
    }
    
    func reloadData() {
        companyNameTextField.text = pwork.companyName
        positionTextField.text = pwork.position
        descriptionTextView.text = pwork.descriptions
        if pwork.fromTime != nil {
            startTimeCell.detailTextLabel?.text = JZDateFormatter.defaultFormatter.toString(pwork.fromTime!, "yyyy年MM月")
        }
        else {
            startTimeCell.detailTextLabel?.text = ""
        }
        if pwork.toTime != nil {
            endTimeCell.detailTextLabel?.text = JZDateFormatter.defaultFormatter.toString(pwork.toTime!, "yyyy年MM月")
        }
        else {
            endTimeCell.detailTextLabel?.text = ""
        }
    }
}
