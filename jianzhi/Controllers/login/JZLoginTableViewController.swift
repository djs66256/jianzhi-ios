//
//  JZLoginTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZLoginTableViewController: JZStaticTableViewController {
    
    @IBOutlet var passwordCell: JZLoginTableViewCell!
    @IBOutlet var userNameCell: JZLoginTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationItem.title = "登录"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registerClicked(sender: AnyObject) {
        let registerController = JZRegisterViewController()
        self.navigationController?.pushViewController(registerController, animated: true)
    }
    
    @IBAction func forgetPassword(sender: AnyObject) {
        let viewController = JZForgetPasswordTableViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func loginClicked(sender: UIButton) {
        sender.userInteractionEnabled = false
        JZUserViewModel.login(userNameCell.textField?.text, password: passwordCell.textField?.text, success: { (userInfo:JZUserInfo) -> Void in
            sender.userInteractionEnabled = true
            
            JZUserManager.sharedManager.currentUser = userInfo
            if self.navigationController != nil {
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            }, failure: { (error:String?) -> Void in
                sender.userInteractionEnabled = true
                JZAlertView.show(error)
        })
        
        if self.navigationController != nil {
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
}
