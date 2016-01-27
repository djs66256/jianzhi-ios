//
//  JZTextFieldEditTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/27.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZTextFieldEditTableViewControllerDelegate : NSObjectProtocol {
    func textFieldEditFinished(viewController: JZTextFieldEditTableViewController, text: String?)
}

class JZTextFieldEditTableViewController: JZStaticTableViewController {
    
    weak var delegate: JZTextFieldEditTableViewControllerDelegate?
    
    var text:String?
    
    @IBOutlet var textFieldCell: JZTextFieldTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: .Bordered, target: self, action: Selector("okButtonClicked"))
        textFieldCell.textField?.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func okButtonClicked() {
        delegate?.textFieldEditFinished(self, text: textFieldCell.textField?.text)
    }
}
