//
//  JZSelectProvinceTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSelectProvinceTableViewController: UITableViewController {

    weak var delegate: JZSelectAreaViewControllerDelegate?
    
    let cellIdentifier = "cell"
    var provinces = [JZProvince]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        JZLocationDataBase.sharedDataBase.findAllProvice { (provinces:[JZProvince]) -> Void in
            self.provinces = provinces
            self.tableView.reloadData()
        }
        
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
        return provinces.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)

        cell.textLabel?.text = provinces[indexPath.row].province

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let province = provinces[indexPath.row]
        JZLocationDataBase.sharedDataBase.findCity(province) { (cities:[JZCity]) -> Void in
            if cities.count > 0 {
                let viewController = JZSelectCityTableViewController()
                viewController.cityList = cities
                viewController.delegate = self.delegate
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            else {
                self.delegate?.selectArea(province.id, area: province.province)
            }
        }
    }

}
