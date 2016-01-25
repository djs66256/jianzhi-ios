//
//  JZCreateResumeTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/3.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZCreateResumeTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "create", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("createResume"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createResume() {
        let resume = JZResume()
        resume.salaryType = JZSalaryTypeBy.month
        resume.descriptions = "哈哈哈哈"
        resume.expectSalary = 8000
        
        let education2 = JZEducation()
        education2.school = "浙江大学"
        education2.major = "电子"
        education2.level = JZEducationLevel.bachelor
        
        
        let education3 = JZEducation()
//        education.school = "浙江大学"
        education3.major = "电子"
        education3.level = JZEducationLevel.bachelor
        
        
        let education = JZEducation()
        education.school = "浙江大学"
//        education.major = "电子"
        education.level = JZEducationLevel.bachelor
        
        resume.educations = [education, education2, education3]
        
        JZResumeViewModel.create(resume, { () -> Void in
            
            }) { (error: String?) -> Void in
                UIAlertView(title: error, message: nil, delegate: nil, cancelButtonTitle: "确定").show()
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
