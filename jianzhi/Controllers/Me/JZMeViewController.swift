//
//  JZMeViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMeViewController: UITableViewController {
    
    let dataArray = [
        ["title":"个人信息","controller":JZMyInfoTableViewController.self],
        ["title":"我的简历", "controller":JZResumeTableViewController.self],
        ["title":"我的公司","controller":JZMyCompanyTableViewController.self],
        ["title":"我的工作","controller":JZMyJobListTableViewController.self],
        ["title":"修改密码","controller":JZChangePasswordTableViewController.self],
        ["title":"关于我们","controller":JZAboutUsViewController.self],
        ["title":"意见反馈","controller":JZFeedbackViewController.self]]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "create", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("createResume"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createResume() {
        let createResumeController = JZCreateResumeTableViewController()
        self.navigationController?.pushViewController(createResumeController, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let title = dataArray[indexPath.row]["title"] as? String {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell") ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
            cell.textLabel?.text = title

            return cell
        }
        else if let cell = dataArray[indexPath.row]["cell"] as? UITableViewCell {
            return cell
        }
        else {
            return UITableViewCell()
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let viewControllerClass = dataArray[indexPath.row]["controller"] as? UIViewController.Type {
            let viewController : UIViewController = viewControllerClass.init()
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
