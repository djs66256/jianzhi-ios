//
//  JZMessageTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageTableViewController: UITableViewController {
    
    let textCellIdentifier = "text"
    let jobCellIdentifier = "job"
    let resumeCellIdentifier = "resume"
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(JZMessageTextCell.self, forCellReuseIdentifier: textCellIdentifier);
        self.tableView.registerClass(JZJobSearchTableCell.self, forCellReuseIdentifier: jobCellIdentifier)
        self.tableView.registerClass(JZMessageResumeCell.self, forCellReuseIdentifier: resumeCellIdentifier)
        
        
        self.navigationItem.title = "某某某"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        

        return cell
    }

    
}
