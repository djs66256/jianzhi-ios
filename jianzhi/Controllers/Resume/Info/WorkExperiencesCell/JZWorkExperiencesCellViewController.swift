//
//  JZWorkExperiencesCellViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZWorkExperiencesCellViewController: JZTableCellTableViewController {
    
    let identifier = "cell"

    var editable = false
    var workExperiences = [JZWorkExperience]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView?.registerNib(UINib(nibName: "JZWorkExperiencesCellTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workExperiences.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! JZWorkExperiencesCellTableViewCell
        
        cell.updateData(workExperiences[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132
    }
}
