//
//  JZEducationsCellViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/25.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZEducationsCellViewController: JZTableCellTableViewController {
    
    let identifier = "edu"
    
    var editable = false
    var educations = [JZEducation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.registerNib(UINib(nibName: "JZEducationCellTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        self.cell.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return educations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! JZEducationCellTableViewCell
        
        cell.updateData(educations[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132
    }
    
    

}
