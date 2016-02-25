//
//  JZSearchViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSearchViewController: JZViewController, JZBaseFilterViewControllerDelegate {
//    let jobCellIdentifier = "job"
    
    var filterViewController: JZBaseFilterViewController?
    var tableViewController: JZSearchBaseTableViewController?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        prepareSearchJobViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareSearchJobViewController() {
        if JZUserManager.sharedManager.currentUser?.userType == .boss && filterViewController is JZPersonFilterViewController {
            return
        }
        if JZUserManager.sharedManager.currentUser?.userType == .jobseeker && filterViewController is JZJobFilterViewController {
            return
        }
        
        filterViewController?.removeFromParentViewController()
        if JZUserManager.sharedManager.currentUser?.userType == .boss {
            filterViewController = JZPersonFilterViewController()
        }
        else {
            filterViewController = JZJobFilterViewController()
        }
        filterViewController!.delegate = self
        view.addSubview(filterViewController!.view)
        filterViewController!.view.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        filterViewController!.view.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        filterViewController!.view.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        self.addChildViewController(filterViewController!)

        tableViewController?.removeFromParentViewController()
        if JZUserManager.sharedManager.currentUser?.userType == .boss {
            tableViewController = JZSearchPersonTableViewController()
        }
        else {
            tableViewController = JZSearchJobTableViewController()
        }
        view.addSubview(tableViewController!.view)
        tableViewController!.view.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        tableViewController!.view.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        tableViewController!.view.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: filterViewController!.view)
        tableViewController!.view.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
        self.addChildViewController(tableViewController!)
    }

    func filterDidChanged(viewController: JZBaseFilterViewController) {
        if let filter = viewController.filter as? JZJobFilter {
            JZSearchViewModel.jobFilter(filter, success: { (items:[JZSearchJobItem]?) -> Void in
                if items != nil {
                    self.tableViewController?.reloadData(items!)
                }
                }, failure: { (error:String?) -> Void in
                    JZAlertView.show(error)
            })
        }
        else if let filter = viewController.filter as? JZPersonFilter {
            // TODO: xxx
        }
    }
}
