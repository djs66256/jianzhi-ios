//
//  JZEditUserBaseInfoTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/27.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZEditUserBaseInfoTableViewController: JZStaticTableViewController, JZTextFieldEditTableViewControllerDelegate, JZTextViewEditTableViewControllerDelegate, JZEditUserGenderTableViewControllerDelegate, JZImagePickerComponentViewControllerDelegate {
    
    var userInfo: JZUserInfo?
    
    let imagePickerComponent = JZImagePickerComponentViewController()
    
    @IBOutlet var headImageCell: JZEditUserHeadImageTableViewCell!
    @IBOutlet var nameCell: UITableViewCell!
    @IBOutlet var genderCell: UITableViewCell!
    @IBOutlet var descriptionCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePickerComponent.delegate = self
        addChildViewController(imagePickerComponent)
        
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
            imagePickerComponent.showController()
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
    
    func imagePickerComponentDidSelect(controller: JZImagePickerComponentViewController, image: UIImage) {
        let compressImage = image.compress(CGSize(width: kJZHeadImageSize, height: kJZHeadImageSize))
        
        JZUserViewModel.uploadHeadImage(compressImage, success: { (id:String) -> Void in
            self.userInfo?.headImage = id
            self.reloadData()
            }, failure: {
                JZAlertView.show($0)
        })
    }
    
    func reloadData() {
        if let url = userInfo?.headImageUrl {
            headImageCell.headImageView.setImageWithURL(url, placeholderImage: nil)
        }
        nameCell.detailTextLabel?.text = userInfo?.nickName
        genderCell.detailTextLabel?.text = userInfo?.gender?.nameValue()
        descriptionCell.detailTextLabel?.text = userInfo?.descriptions
        tableView.reloadData()
    }
}
