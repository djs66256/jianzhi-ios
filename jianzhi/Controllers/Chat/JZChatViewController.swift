//
//  JZChatViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZChatViewController: UITableViewController {
    
    static let myChatCellIdentifier = "myChat"
    let otherChatCellIdentifier = "otherChat"
    
    var groups = [JZMessageGroup]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(JZChatBaseTableViewCell.self, forCellReuseIdentifier: JZChatViewController.myChatCellIdentifier)
        
        self.navigationItem.title = "消息"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "insert", style: .Bordered, target: self, action: Selector("insertGroup"))
        
        
        reloadGroups()
    }
    
    func insertGroup() {
        let group = JZMessageGroup()
        group.title = "test group"
        group.type = .Chat
        group.user = JZUserManager.sharedManager.currentUser
//        JZUserDataBase.sharedDataBase.insertMessageGroup(group)
        self.groups = [group]
        self.tableView.reloadData()
    }
    
    func reloadGroups() {
        
        JZUserDataBase.sharedDataBase.findUserById(JZUserManager.sharedManager.currentUser?.uid ?? 0) { (user:JZUserInfo?) -> Void in
            if user == nil {
                JZUserDataBase.sharedDataBase.insertUser(JZUserManager.sharedManager.currentUser!)
            }
        }
        
        JZUserDataBase.sharedDataBase.findGroups {
            self.groups = $0
            self.tableView.reloadData()
        }
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
        return groups.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(JZChatViewController.myChatCellIdentifier, forIndexPath: indexPath)

        let group = groups[indexPath.row]
        cell.textLabel?.text = group.title
        

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let messageController = JZMessageViewController(group: groups[indexPath.row])
        messageController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(messageController, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
