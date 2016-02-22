//
//  JZChatViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZChatViewController: UITableViewController {
    let chatCellIdentifier = "chat"
    let myChatCellIdentifier = "myChat"
    let otherChatCellIdentifier = "otherChat"
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.tableView.registerClass(JZChatBaseTableViewCell.self, forCellReuseIdentifier: JZChatViewController.myChatCellIdentifier)
        tableView.registerNib(UINib(nibName: "JZChatGroupTableViewCell", bundle: nil), forCellReuseIdentifier: chatCellIdentifier)
        tableView.tableFooterView = UIView()
        
        self.navigationItem.title = "消息"
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reloadGroups"), name: JZNotification.MessageGroupReload, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func reloadGroups() {
        self.tableView.reloadData()
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
        return JZMessageGroupService.instance.groups.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(chatCellIdentifier, forIndexPath: indexPath) as? JZChatGroupTableViewCell {
            
            let group = JZMessageGroupService.instance.groups[indexPath.row]
            cell.updateData(group)
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let group = JZMessageGroupService.instance.groups[indexPath.row]
            JZMessageGroupService.instance.remove(group)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let group = JZMessageGroupService.instance.groups[indexPath.row]
        let messageController = JZMessageViewController(group: group)
        messageController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(messageController, animated: true)
        
        JZMessageService.instance.clearUnreadByGroup(group)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }
}
