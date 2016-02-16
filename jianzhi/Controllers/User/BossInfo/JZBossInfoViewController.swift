//
//  JZBossInfoViewController.swift
//  jianzhi
//
//  Created by daniel on 16/2/16.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZBossInfoViewController: UIViewController {

    let tableViewController = JZBossInfoTableViewController()
    
    @IBOutlet weak var bottomView: UIView!
    
    var userId: Int? {
        didSet {
            tableViewController.userId = userId
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .None
        
        view.addSubview(tableViewController.view)
        tableViewController.view.autoPinEdgeToSuperviewEdge(.Top)
        tableViewController.view.autoPinEdgeToSuperviewEdge(.Left)
        tableViewController.view.autoPinEdgeToSuperviewEdge(.Right)
        tableViewController.view.autoPinEdge(.Bottom, toEdge: .Top, ofView: bottomView)
        
        addChildViewController(tableViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
