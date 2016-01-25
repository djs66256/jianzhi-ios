//
//  JZTableCellTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/25.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZTableCellTableViewController: JZTableCellViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tableView == nil {
            tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.Plain)
            tableView!.delegate = self
            tableView!.dataSource = self
            tableView!.scrollEnabled = false
            self.cell.contentView.addSubview(tableView!)
            tableView!.autoPinEdgesToSuperviewEdges()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    func reloadData() {
        self.tableView?.reloadData()
        let size = self.tableView?.sizeThatFits(CGSize(width: 1, height: CGFloat.max))
        self.view.frame.size.height = size?.height ?? 0
    }

}
