//
//  JZRegisterCompanyTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/4.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZRegisterCompanyTableViewController: JZViewController {
    
    var userInfo : JZBossUserInfo?
    var company : JZCompany {
        return companyViewController.company
    }
    
    let companyViewController = JZCompanyEditableTableViewController()
    
    @IBOutlet var tableFooterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("nextStep"))
        self.navigationItem.title = "完善公司信息"
        
        view.addSubview(companyViewController.view)
        companyViewController.view.autoPinEdgesToSuperviewEdges()
        companyViewController.tableView.tableFooterView = tableFooterView
        addChildViewController(companyViewController)
    }

    @IBAction func nextStep(sender:UIButton) {
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
