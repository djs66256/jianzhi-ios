//
//  JZTextViewEditTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/27.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZTextViewEditTableViewControllerDelegate : NSObjectProtocol {
    func textViewEditFinished(viewController:JZTextViewEditTableViewController, text:String?)
}

class JZTextViewEditTableViewController: JZStaticTableViewController {
    
    weak var delegate: JZTextViewEditTableViewControllerDelegate?
    
    var text: String?
    
    @IBOutlet var textViewCell: JZTextViewTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: .Bordered, target: self, action: Selector("okButtonClicked"))
        
        textViewCell.textView?.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func okButtonClicked() {
        delegate?.textViewEditFinished(self, text: textViewCell.textView?.text)
    }
}
