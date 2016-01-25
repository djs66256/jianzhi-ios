//
//  JZInviteTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/4.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZInviteTableViewController: UITableViewController {
    
    @IBOutlet var inviteCell: UITableViewCell!
    @IBOutlet var messageCell: UITableViewCell!
    @IBOutlet var selectJobCell: UITableViewCell!
    var cellArray : [UITableViewCell] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "邀请"
        self.cellArray = [selectJobCell, messageCell, inviteCell]
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
        return self.cellArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        return cellArray[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0 {
            let viewController = JZSelectJobListTableViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
