//
//  JZImagePickerViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/27.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZImagePickerViewControllerType {
    case Album, Camera
}

protocol JZImagePickerViewControllerDelegate : NSObjectProtocol {
    func imagePickerFinished(controller:JZImagePickerViewController, type: JZImagePickerViewControllerType)
}

class JZImagePickerViewController: JZActionSheetViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: JZImagePickerViewControllerDelegate?
    
    let dataSource = [["从相册中选择", "拍照"],["取消"]]
    
    var tableView : UITableView? {
        return contentView as? UITableView
    }
    
    override func viewDidLoad() {
        tableView?.reloadData()
        tableView?.sizeToFit()
        if #available(iOS 8.0, *) {
            tableView?.layoutMargins = UIEdgeInsetsZero
        }
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            cell?.textLabel?.textAlignment = .Center
            cell?.separatorInset = UIEdgeInsetsZero
            if #available(iOS 8.0, *) {
                cell!.layoutMargins = UIEdgeInsetsZero
            }
        }
        cell!.textLabel?.text = dataSource[indexPath.section][indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView()
            view.backgroundColor = UIColor(white: 0.7, alpha: 1)
            return view
        }
        return nil
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 {
            dismiss()
        }
        else {
            if indexPath.row == 0 {
                delegate?.imagePickerFinished(self, type: .Album)
            }
            else {
                delegate?.imagePickerFinished(self, type: .Camera)
            }
        }
    }

}
