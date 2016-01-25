//
//  JZForgetPasswordTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/4.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZForgetPasswordTableViewController: UITableViewController {
    
    var identifyingCode: String?
        
    @IBOutlet var accountCell: JZTextFieldTableViewCell!
    @IBOutlet var identifyCell: JZIdentifyingCodeCellTableViewCell!
    
    @IBOutlet var passwordCell: JZTextFieldTableViewCell!
    @IBOutlet var buttonCell: UITableViewCell!
    
    var cellArray = [UITableViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cellArray = [accountCell, identifyCell, passwordCell, buttonCell]
        self.navigationItem.title = "忘记密码"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellArray[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGRectGetHeight(cellArray[indexPath.row].frame)
    }
    
    @IBAction func identifyingCodeClicked(sender: AnyObject) {
        JZUserViewModel.getPhoneIdentifyingCode(accountCell.textField?.text, success: { (code:String) -> Void in
            self.identifyingCode = code
            }, failure: { (error:String?) -> Void in
                self.identifyCell.button?.endTick()
                JZAlertView.show(error)
        })
    }
    
    @IBAction func forgetPassword(sender:UIButton) {
        #if !DEBUG
            if self.identifyingCode == nil || self.identifyingCode != identifyCell.textField?.text {
                JZAlertView.show("验证码错误")
                return
            }
        #endif
        JZUserViewModel.forgetPasswor(accountCell.textField?.text, password: passwordCell.textField?.text, validate: identifyCell.textField?.text, success: { () -> Void in
            JZAlertView.show("修改成功")
            self.navigationController?.popViewControllerAnimated(true)
            }, failure: { (error:String?) -> Void in
                JZAlertView.show(error)
        })
    }
}
