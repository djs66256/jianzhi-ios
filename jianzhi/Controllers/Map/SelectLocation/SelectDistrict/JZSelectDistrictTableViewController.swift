//
//  JZSelectDistrictTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSelectDistrictTableViewController: UITableViewController {
    let cellIdentifier = "cell"
    
    weak var delegate: JZSelectAreaViewControllerDelegate?
    
    var city: JZCity?
    var districtList: [JZDistrict]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
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
        return districtList?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)

        cell.textLabel?.text = districtList![indexPath.row].district

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let district = districtList![indexPath.row]
        
        self.delegate?.selectArea(district.id, area: (district.city?.province?.province ?? "") + (district.city?.city ?? "") + district.district)
    }
}
