//
//  JZRegisterCompanyTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/4.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZRegisterCompanyTableViewController: JZStaticTableViewController, JZSelectLocationViewControllerDelegate {
    
    var userInfo : JZBossUserInfo?
    var company = JZCompany()
    
    @IBOutlet var nameCell: JZTextFieldTableViewCell!
    @IBOutlet var descriptionCell: JZTextViewTableViewCell!
    @IBOutlet var addressCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("nextStep"))
        self.navigationItem.title = "完善公司信息"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = cellAtIndexPath(indexPath)
        if cell == addressCell {
            let viewController = JZSelectLocationViewController()
            viewController.delegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func selectAddress(viewController: JZSelectLocationViewController, code: Int?, address: String?) {
        company.address = address
        company.addressCode = code
        
        self.addressCell.detailTextLabel?.text = address
        self.tableView.reloadData()
    }

    @IBAction func nextStep(sender:UIButton) {
        company.name = nameCell.textField?.text
        company.descriptions = descriptionCell.textView?.text
        
        sender.userInteractionEnabled = false
        JZCompanyViewModel.edit(company, success: { () -> Void in
            sender.userInteractionEnabled = true
            self.userInfo?.company = self.company
            let viewController = JZRegisterJobTableViewController()
            viewController.userInfo = self.userInfo
            self.navigationController?.pushViewController(viewController, animated: true)
            }, failure: { (error:String?) -> Void in
                sender.userInteractionEnabled = true
                JZAlertView.show(error)
        })
    }
    
    
}
