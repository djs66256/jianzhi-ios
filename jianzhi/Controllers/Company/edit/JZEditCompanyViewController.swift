//
//  JZEditCompanyViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZEditCompanyViewControllerDelegate : NSObjectProtocol {
    func editCompanyViewDidFinished(viewController:JZEditCompanyViewController, company:JZCompany)
}

class JZEditCompanyViewController: UIViewController {

    weak var delegate: JZEditCompanyViewControllerDelegate?
    
    let companyViewController = JZCompanyEditableTableViewController()
    
    var company : JZCompany? {
        get {
            return companyViewController.company
        }
        set {
            companyViewController.company = newValue ?? JZCompany()
        }
    }
    
    @IBOutlet var tableFooterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        companyViewController.tableView.tableFooterView = tableFooterView
        view.addSubview(companyViewController.view)
        companyViewController.view.autoPinEdgesToSuperviewEdges()
        addChildViewController(companyViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonClicked(sender: AnyObject) {
        let company = companyViewController.company
        JZCompanyViewModel.edit(company, success: {
            self.delegate?.editCompanyViewDidFinished(self, company: company)
            }, failure: {
                JZAlertView.show($0)
        })
    }

}
