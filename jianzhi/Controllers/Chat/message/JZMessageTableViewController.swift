//
//  JZMessageTableViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageTableViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let myTextCellIdentifier = "mytext"
    let myJobCellIdentifier = "myjob"
    let myResumeCellIdentifier = "myresume"
    let otherTextCellIdentifier = "othertext"
    let otherJobCellIdentifier = "otherjob"
    let otherResumeCellIdentifier = "otherresume"
        
    @IBOutlet var messageEditView: JZMessageEditView!
    
    var messages = [JZMessage]()
    private var rowHeights = [CGFloat]()
    
    var tableView: UITableView {
        set {
            view = newValue
        }
        get {
            return view as! UITableView
        }
    }
    
    override func loadView() {
        self.view = UITableView(frame: CGRectZero, style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(JZMessageMyTextCell.self, forCellReuseIdentifier: myTextCellIdentifier);
        self.tableView.registerClass(JZMessageMyJobCell.self, forCellReuseIdentifier: myJobCellIdentifier)
        self.tableView.registerClass(JZMessageMyResumeCell.self, forCellReuseIdentifier: myResumeCellIdentifier)
        self.tableView.registerClass(JZMessageOtherTextCell.self, forCellReuseIdentifier: otherTextCellIdentifier);
        self.tableView.registerClass(JZMessageOtherJobCell.self, forCellReuseIdentifier: otherJobCellIdentifier)
        self.tableView.registerClass(JZMessageOtherResumeCell.self, forCellReuseIdentifier: otherResumeCellIdentifier)
        
        self.tableView.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData(animate: Bool) {
        rowHeights.removeAll()
        for message in messages {
            rowHeights.append(rowHeight(message))
        }
        
        self.tableView.reloadData()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.scrollToBottom(animate)
        }
    }
    
    func insertMessage(message: JZMessage) {
        messages.append(message)
        rowHeights.append(rowHeight(message))
        
        tableView.reloadData()
        dispatch_async(dispatch_get_main_queue()) {
            self.scrollToBottom(true)
        }
    }
    
    func scrollToBottom(animate: Bool) {
        let offsetY = self.tableView.contentSize.height - (self.tableView.frame.height - self.tableView.contentInset.bottom)
        self.tableView.setContentOffset(CGPointMake(0, offsetY>0 ? offsetY : 0), animated: animate)
    }

    // MARK: - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        var cell: JZMessageBaseCell? = nil
        if let myId = JZUserManager.sharedManager.currentUser?.uid {
            guard myId != 0 else { return UITableViewCell() }
            
            switch message.type {
            case .Message:
                if message.user?.uid == myId {
                    if let myTextCell = tableView.dequeueReusableCellWithIdentifier(myTextCellIdentifier, forIndexPath: indexPath) as? JZMessageMyTextCell {
                        cell = myTextCell
                    }
                }
                else {
                    if let otherTextCell = tableView.dequeueReusableCellWithIdentifier(otherTextCellIdentifier, forIndexPath: indexPath) as? JZMessageOtherTextCell {
                        cell = otherTextCell
                    }
                }
                
            case .Job:
                if message.user?.uid == myId {
                    if let myJobCell = tableView.dequeueReusableCellWithIdentifier(myJobCellIdentifier, forIndexPath: indexPath) as? JZMessageMyJobCell {
                        cell = myJobCell
                    }
                }
                else {
                    if let otherJobCell = tableView.dequeueReusableCellWithIdentifier(otherJobCellIdentifier, forIndexPath: indexPath) as? JZMessageOtherJobCell {
                        cell = otherJobCell
                    }
                }
                
            case .Person:
                if message.user?.uid == myId {
                    if let myResumeCell = tableView.dequeueReusableCellWithIdentifier(myResumeCellIdentifier, forIndexPath: indexPath) as? JZMessageMyResumeCell {
                        cell = myResumeCell
                    }
                }
                else {
                    if let otherResumeCell = tableView.dequeueReusableCellWithIdentifier(otherResumeCellIdentifier, forIndexPath: indexPath) as? JZMessageMyResumeCell {
                        cell = otherResumeCell
                    }
                }
            default:
                cell = nil
            }
        }
        
        cell?.updateMessage(message)

        return cell ?? UITableViewCell()
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeights[indexPath.row]
    }
    
    func rowHeight(message: JZMessage) -> CGFloat {
        if let myId = JZUserManager.sharedManager.currentUser?.uid {
            guard myId != 0 else { return 0 }
            
            switch message.type {
            case .Message:
                if message.user?.uid == myId {
                    return JZMessageMyTextCell.heightForMessage(message, width: tableView.frame.width)
                }
                else {
                    return JZMessageOtherTextCell.heightForMessage(message, width: tableView.frame.width)
                }
                
            case .Job:
                if message.user?.uid == myId {
                    return JZMessageMyJobCell.heightForMessage(message, width: tableView.frame.width)
                }
                else {
                    return JZMessageOtherJobCell.heightForMessage(message, width: tableView.frame.width)
                }
                
            case .Person:
                if message.user?.uid == myId {
                    return JZMessageMyResumeCell.heightForMessage(message, width: tableView.frame.width)
                }
                else {
                    return JZMessageOtherResumeCell.heightForMessage(message, width: tableView.frame.width)
                }
            default:
                return 0
            }
        }
        return 0
    }
    
     func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        parentViewController?.resignFirstResponder()
    }
    
}
