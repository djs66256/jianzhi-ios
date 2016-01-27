//
//  JZCompanyCellViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZCompanyCellViewController: UIViewController, JZEditCompanyViewControllerDelegate {

    var company: JZCompany?
    var editable = false {
        didSet {
            editableChanged(editable)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func editableChanged(editable:Bool) {
        self.editButton.hidden = !editable
    }

    func reloadData() {
        nameLabel.text = company?.name
        descriptionLabel.text = company?.descriptions
        addressLabel.text = company?.address
    }

    @IBAction func editCompanyClicked() {
        let viewController = JZEditCompanyViewController()
        viewController.company = company
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func editCompanyViewDidFinished(viewController: JZEditCompanyViewController, company: JZCompany) {
        viewController.navigationController?.popViewControllerAnimated(true)
        self.company = company
        
        reloadData()
        if let vc = self.parentViewController as? UITableViewController {
            vc.tableView.reloadData()
        }
    }
}
