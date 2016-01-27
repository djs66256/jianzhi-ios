//
//  JZEditUserBaseInfoTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/27.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZEditUserBaseInfoTableViewController: JZStaticTableViewController, JZTextFieldEditTableViewControllerDelegate, JZTextViewEditTableViewControllerDelegate, JZEditUserGenderTableViewControllerDelegate {
    
    var userInfo: JZUserInfo?
    
    @IBOutlet var headImageCell: JZEditUserHeadImageTableViewCell!
    @IBOutlet var nameCell: UITableViewCell!
    @IBOutlet var genderCell: UITableViewCell!
    @IBOutlet var descriptionCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = cellAtIndexPath(indexPath)
        if cell == headImageCell {
            
        }
        else if cell == nameCell {
            let viewController = JZTextFieldEditTableViewController()
            viewController.delegate = self
            viewController.text = userInfo?.nickName
            navigationController?.pushViewController(viewController, animated: true)
        }
        else if cell == genderCell {
            let viewController = JZEditUserGenderTableViewController()
            viewController.delegate = self
            viewController.gender = userInfo?.gender ?? .unknow
            navigationController?.pushViewController(viewController, animated: true)
        }
        else if cell == descriptionCell {
            let viewController = JZTextViewEditTableViewController()
            viewController.delegate = self
            viewController.text = userInfo?.descriptions
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func textFieldEditFinished(viewController: JZTextFieldEditTableViewController, text: String?) {
        JZUserViewModel.editNickName(text, success: { () -> Void in
            self.userInfo?.nickName = text
            self.reloadData()
            viewController.navigationController?.popViewControllerAnimated(true)
            }, failure: {
                JZAlertView.show($0)
        })
    }
    
    func textViewEditFinished(viewController: JZTextViewEditTableViewController, text: String?) {
        JZUserViewModel.editDescription(text, success: { () -> Void in
            self.userInfo?.descriptions = text
            self.reloadData()
            viewController.navigationController?.popViewControllerAnimated(true)
            }, failure: {
                JZAlertView.show($0)
        })
    }
    
    func editUserGenderFinished(viewController: JZEditUserGenderTableViewController, gender: JZGenderType) {
        JZUserViewModel.editGender(gender, success: { () -> Void in
            self.userInfo?.gender = gender
            self.reloadData()
            viewController.navigationController?.popViewControllerAnimated(true)
            }, failure: {
                JZAlertView.show($0)
        })
    }
    
    func reloadData() {
        nameCell.detailTextLabel?.text = userInfo?.nickName
        genderCell.detailTextLabel?.text = userInfo?.gender?.nameValue()
        descriptionCell.detailTextLabel?.text = userInfo?.descriptions
        tableView.reloadData()
    }
}
