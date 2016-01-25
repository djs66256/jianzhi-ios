//
//  JZSelectLocationViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/16.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZSelectLocationViewControllerDelegate: NSObjectProtocol {
    func selectAddress(viewController: JZSelectLocationViewController, code:Int?, address:String?)
}

class JZSelectLocationViewController: JZStaticTableViewController, JZSelectAreaViewControllerDelegate {
    
    weak var delegate: JZSelectLocationViewControllerDelegate?
    
    var code: Int?
    var area: String?

    @IBOutlet var districtCell: UITableViewCell!
    @IBOutlet var addressCell: JZTextFieldTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if cellAtIndexPath(indexPath) == districtCell {
            let viewController = JZSelectAreaViewController()
            viewController.delegate = self
            viewController.showInController(self)
        }
    }
    
    func selectArea(code: Int, area: String) {
        districtCell.detailTextLabel?.text = area
        self.code = code
        self.area = area
        self.tableView.reloadData()
    }

    @IBAction func okButtonClicked(sender: AnyObject) {
        self.delegate?.selectAddress(self, code: code, address: (area ?? "") + (addressCell.textField?.text ?? ""))
        self.navigationController?.popViewControllerAnimated(true)
    }
}
