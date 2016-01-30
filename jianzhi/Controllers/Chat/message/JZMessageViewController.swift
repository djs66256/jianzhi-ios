//
//  JZMessageViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/30.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageViewController: UIViewController, JZMessageEditViewControllerDelegate {

    
    final var messageEditController = JZMessageEditViewController()
    final var messageTableController = JZMessageTableViewController()
    private var tableHeightConstraint: NSLayoutConstraint?
    
//    private var messageEditing = false {
//        didSet {
//            messageTableController.tableView.scrollEnabled = !messageEditing
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .None
        view.addSubview(messageTableController.view)
        view.addSubview(messageEditController.view)
        addChildViewController(messageTableController)
        addChildViewController(messageEditController)
        
//        let height = UIScreen.mainScreen().applicationFrame.height - navigationController!.navigationBar.frame.height - messageEditController.view.frame.height
//        tableHeightConstraint = messageTableController.view.autoSetDimension(.Height, toSize: height)
//        messageTableController.view.autoPinEdgeToSuperviewEdge(.Top)
//        messageTableController.view.autoPinEdgeToSuperviewEdge(.Left)
//        messageTableController.view.autoPinEdgeToSuperviewEdge(.Right)
//        messageTableController.view.autoPinEdgeToSuperviewEdge(.Bottom)
//        messageTableController.view.autoPinEdge(.Bottom, toEdge: .Top, ofView: messageEditController.view)
        messageTableController.view.autoPinEdgesToSuperviewEdges()
//        messageTableController.tableView.tableFooterView = UIView(frame: CGRectMake(0,0,100, messageEditController.view.frame.height))
        messageTableController.view.backgroundColor = UIColor(patternImage: UIImage(named: "anno")!)
        messageTableController.tableView.contentInset = UIEdgeInsetsMake(0, 0, messageEditController.view.frame.height, 0)
        
        messageEditController.view.autoPinEdgeToSuperviewEdge(.Bottom)
        messageEditController.view.autoPinEdgeToSuperviewEdge(.Left)
        messageEditController.view.autoPinEdgeToSuperviewEdge(.Right)
        messageEditController.heightConstraint = messageEditController.view.autoSetDimension(.Height, toSize: messageEditController.view.frame.height)
        messageEditController.delegate = self
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData() {
        var list = [JZMessage]()
        
        var content:String = ""
        for i in 1...10 {
            let m = JZMessage()
            m.user = JZUserInfo(uid:i, userName:"user:\(i)")
            content += "content: \(i)\n"
            m.content = content
            m.type = .Message
            list.append(m)
        }
        
        messageTableController.messages = list
        messageTableController.reloadData(false)
    }
    
    override func canResignFirstResponder() -> Bool {
        return messageEditController.canResignFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return messageEditController.resignFirstResponder()
    }

    func messageEditViewControllerHeightDidChange(controller: JZMessageEditViewController, height: CGFloat, duration:NSTimeInterval) {
        self.messageEditController.heightConstraint?.constant = height
        self.view.layoutIfNeeded()
        
        let moveY = self.messageTableController.tableView.contentSize.height - (self.messageTableController.tableView.frame.height - height)
        let offsetY = moveY > 0 ? moveY : 0
        if fabs(self.messageTableController.tableView.contentOffset.y - offsetY) < messageTableController.tableView.frame.height {
            self.messageTableController.tableView.contentOffset.y = offsetY
        }
        else {
            self.messageTableController.tableView.setContentOffset(CGPointMake(0, offsetY), animated: true)
        }
        self.messageTableController.tableView.contentInset.bottom = height
    }
    
    func messageEditViewControllerDidSendMessage(controller: JZMessageEditViewController, text: String) {
        let message = JZMessage()
        message.user = JZUserManager.sharedManager.currentUser
        message.time = NSDate()
        message.type = .Message
        message.content = text
        
        messageTableController.insertMessage(message)
    }
    
}
