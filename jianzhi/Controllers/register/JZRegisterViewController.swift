//
//  JZRegisterViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZRegisterViewController: JZStaticTableViewController {
    
//    var userInfo: JZUserInfo?
    var identifyingCode : String?
        
    @IBOutlet var buttonsCell: UITableViewCell!
    @IBOutlet var passwordCell: JZRegisterTableViewCell!
    @IBOutlet var userNameCell: JZRegisterTableViewCell!
    @IBOutlet var identifyCell: JZIdentifyingCodeCellTableViewCell!
    
    @IBOutlet weak var jobseekerButton: UIButton!
    @IBOutlet weak var bossButton: UIButton!
    
//    var cellArray : [UITableViewCell]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cellArray = [userNameCell, identifyCell, passwordCell, buttonsCell]
        
        self.navigationItem.title = "注册"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.edgesForExtendedLayout = UIRectEdge.None
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
        return cellArray[indexPath.row].frame.size.height
    }
    
    @IBAction func registerClicked(sender: AnyObject) {
        #if !DEBUG
        if self.identifyingCode == nil || self.identifyingCode != identifyCell.textField?.text {
            JZAlertView.show("验证码错误")
            return
        }
        #endif
        
        var type : JZUserType = JZUserType.jobseeker
        if jobseekerButton.selected {
            type = .jobseeker
        }
        if bossButton.selected {
            type = .boss
        }
        
        let password = passwordCell.textField!.text
        JZUserViewModel.register(userNameCell.textField!.text,
            password: password,
            validate: identifyCell.textField!.text,
            type: type,
            success: { (userInfo:JZUserInfo) -> Void in
                // then login
                JZUserViewModel.login(userInfo.userName, password: password, success: { (userInfo:JZUserInfo) -> Void in
                    // next page, fix detail info
                    let viewController = JZRegisterDetailInfoTableViewController()
                    viewController.userInfo = userInfo
                    JZUserManager.sharedManager.currentUser = userInfo
                    self.navigationController?.pushViewController(viewController, animated: true)

                    }, failure: { (error:String?) -> Void in
                        JZAlertView.show(error)
                })
            },
            failure: { (error:String?) -> Void in
                JZAlertView.show(error)
        })

    }

    
    @IBAction func jobseekerClicked(sender: AnyObject) {
        jobseekerButton.selected = true
        bossButton.selected = false
    }
    
    @IBAction func bossClicked(sender: AnyObject) {
        jobseekerButton.selected = false
        bossButton.selected = true
    }
    
    @IBAction func identifyingCodeClicked(sender: AnyObject) {
        JZUserViewModel.getPhoneIdentifyingCode(userNameCell.textField?.text, success: { (code:String) -> Void in
            self.identifyingCode = code
            }, failure: { (error:String?) -> Void in
                self.identifyCell.button?.endTick()
                JZAlertView.show(error)
        })
    }
    
}
