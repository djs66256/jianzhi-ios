//
//  JZSelectJobListTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/4.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZSelectJobListTableViewControllerDelegate: NSObjectProtocol {
    func didSelectJob(controller: JZSelectJobListTableViewController, job: JZJob)
}

class JZSelectJobListTableViewController: JZTableViewController {
    let cellIdentifier = "job"
    
    weak var delegate: JZSelectJobListTableViewControllerDelegate?
    var jobList = [JZJob]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "选择工作"
        tableView.registerNib(UINib(nibName: "JZSelectJobListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        JZJobViewModel.myInfo({ (jobList) -> Void in
            self.jobList = jobList
            self.tableView.reloadData()
            }, failure: { JZAlertView.show($0) })
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
        return jobList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! JZSelectJobListTableViewCell

        cell.updateData(jobList[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        delegate?.didSelectJob(self, job: jobList[indexPath.row])
    }
    
}
