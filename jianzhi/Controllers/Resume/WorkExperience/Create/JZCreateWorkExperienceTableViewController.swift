//
//  JZCreateWorkExperienceTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/6.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZCreateWorkExperienceTableViewControllerDelegate : NSObjectProtocol {
    func createWorkExperience(viewController:JZCreateWorkExperienceTableViewController, _ workExperience: JZWorkExperience)
}

class JZCreateWorkExperienceTableViewController: JZStaticTableViewController, JZYearMonthPickerViewControllerDelegate {
    
    weak var delegate : JZCreateWorkExperienceTableViewControllerDelegate?
    
    var work = JZWorkExperience()
    
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet var startTimeCell: UITableViewCell!
    @IBOutlet var endTimeCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "创建工作经验"
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
    
    @IBAction func saveClicked(sender: AnyObject) {
        work.companyName = companyNameTextField.text
        work.position = positionTextField.text
        work.descriptions = descriptionTextView.text
        
        JZWorkExperienceViewModel.create(work, success: { (work:JZWorkExperience) -> Void in
            self.delegate?.createWorkExperience(self, work)
            }, failure: { (error:String?) -> Void in
                JZAlertView.show(error)
        })
        
    }

}
