//
//  JZCompanyEditableTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZCompanyEditableTableViewController: JZStaticTableViewController, JZSelectLocationViewControllerDelegate {
    
    private var cmp = JZCompany()
    
    var company : JZCompany {
        get {
            cmp.name = nameCell.textField?.text
            cmp.descriptions = descriptionCell.textView?.text
            return cmp
        }
        set {
            cmp = (newValue.copy() as? JZCompany) ?? JZCompany()
        }
    }
    
    @IBOutlet var nameCell: JZTextFieldTableViewCell!
    @IBOutlet var descriptionCell: JZTextViewTableViewCell!
    @IBOutlet var addressCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = cellAtIndexPath(indexPath)
        if cell == addressCell {
            let viewController = JZSelectLocationViewController()
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func selectAddress(viewController: JZSelectLocationViewController, code: Int?, address: String?) {
        cmp.address = address
        cmp.addressCode = code
        
        addressCell.detailTextLabel?.text = address
        tableView.reloadData()
    }

    func reloadData() {
        nameCell.textField?.text = cmp.name
        addressCell.detailTextLabel?.text = cmp.address
        descriptionCell.textView?.text = cmp.descriptions
        
        tableView.reloadData()
    }
}
