//
//  JZEditUserGenderTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/27.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZEditUserGenderTableViewControllerDelegate : NSObjectProtocol {
    func editUserGenderFinished(viewController:JZEditUserGenderTableViewController, gender:JZGenderType)
}

class JZEditUserGenderTableViewController: UITableViewController {
    
    weak var delegate: JZEditUserGenderTableViewControllerDelegate?
    
    var gender: JZGenderType = .unknow
    
    let dataSource = [JZGenderType.male, JZGenderType.female, JZGenderType.unknow]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "修改性别"
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
        return dataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: identifier)
        }
        
        let gender = dataSource[indexPath.row]
        if gender == self.gender {
            cell!.accessoryType = .Checkmark
        }
        else {
            cell!.accessoryType = .None
        }
        cell!.textLabel?.text = gender.nameValue()

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let gender = dataSource[indexPath.row]
        delegate?.editUserGenderFinished(self, gender: gender)
        self.gender = gender
        tableView.reloadData()
    }
    
}
