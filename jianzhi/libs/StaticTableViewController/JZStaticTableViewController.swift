//
//  JZStaticTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/7.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZStaticTableViewController: UITableViewController {
    
    @IBOutlet var cellArray: [UITableViewCell]!
    @IBOutlet var tableHeaderView: UIView?
    @IBOutlet var tableFooterView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = tableHeaderView
        self.tableView.tableFooterView = tableFooterView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellArray[indexPath.row]
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellArray[indexPath.row].frame.height
    }
    
    
    func cellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        return cellArray[indexPath.row]
    }
}
