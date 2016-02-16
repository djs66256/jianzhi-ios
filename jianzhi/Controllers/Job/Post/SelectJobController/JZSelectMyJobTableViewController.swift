//
//  JZSelectMyJobTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/2/16.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZSelectMyJobTableViewControllerDelegate : NSObjectProtocol {
    func didSelectJob(controller:JZSelectMyJobTableViewController, job:JZJob)
}

class JZSelectMyJobTableViewController: UITableViewController, JZCreateJobViewControllerDelegate {
    private let cellIdentifier = "job"
    
    weak var delegate: JZSelectMyJobTableViewControllerDelegate?
    
    private var jobList = [JZJob]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新建", style: .Bordered, target: self, action: Selector("createJob"))

        tableView.registerNib(UINib(nibName: "JZJobListCellTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        JZJobViewModel.myInfo({ (jobList) -> Void in
            self.jobList = jobList
            self.tableView.reloadData()
            }, failure: {
                JZAlertView.show($0)
        })
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! JZJobListCellTableViewCell

        cell.updateData(jobList[indexPath.row])

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        delegate?.didSelectJob(self, job: jobList[indexPath.row])
    }

    func createJob() {
        let controller = JZCreateJobViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func createJob(viewController: JZCreateJobViewController, _ job: JZJob) {
        self.delegate?.didSelectJob(self, job: job)
        
        viewController.navigationController?.popViewControllerAnimated(true)
//        self.navigationController?.popViewControllerAnimated(true)
    }
}
