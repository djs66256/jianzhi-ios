//
//  JZSelectCityTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSelectCityTableViewController: UITableViewController {
    
    let cellIdentifier = "cell"
    
    weak var delegate: JZSelectAreaViewControllerDelegate?
    
    var province: JZProvince?
    var cityList: [JZCity]?

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
        return cityList?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)

        cell.textLabel?.text = cityList![indexPath.row].city

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let city = cityList![indexPath.row]
        JZLocationDataBase.sharedDataBase.findDistrict(city) { (districts:[JZDistrict]) -> Void in
            if districts.count > 0 {
                let viewController = JZSelectDistrictTableViewController()
                viewController.delegate = self.delegate
                viewController.districtList = districts
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            else {
                self.delegate?.selectArea(city.id, area: city.province?.province ?? "" + city.city)
            }
        }
    }
}
