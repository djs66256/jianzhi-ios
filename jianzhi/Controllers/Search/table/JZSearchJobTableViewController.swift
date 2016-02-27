//
//  JZSearchJobTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/24.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSearchJobTableViewController: JZSearchBaseTableViewController {

    final let cellIdentifier = "job"
    
    var dataSource = [JZSearchJobItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerNib(UINib(nibName: "JZJobSearchTableCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! JZJobSearchTableCell

        let data = dataSource[indexPath.row]
        cell.updateData(data)

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let viewController = JZDetialJobInfoViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.jobId = dataSource[indexPath.row].id
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func reloadData(items: [AnyObject]) {
        if let data = items as? [JZSearchJobItem] {
            self.dataSource = data
            self.tableView.reloadData()
        }
    }

}
