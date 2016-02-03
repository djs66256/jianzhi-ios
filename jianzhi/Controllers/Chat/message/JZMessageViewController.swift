//
//  JZMessageViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/31.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageViewController: JSQMessagesViewController {
    
    var messages = [JZMessage]()
    var group = JZMessageGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = "5"
        self.senderDisplayName = "Me"
        self.showLoadEarlierMessagesHeader = true

        // Do any additional setup after loading the view.
        for i in 0...10 {
            let user = JZUserInfo()
            user.uid = i
            user.nickName = "user\(i)"
            let message = JZMessage(user: user, text: "text \(i)", date: NSDate(), type: .Message, group: group)
            message.text = "message content: \(i)"
            message.date = NSDate()
            messages.append(message)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    
//    func collectionView(collectionView:JSQMessagesCollectionView, bubbleImageViewForItemAtIndexPath indexPath:NSIndexPath) -> UIImageView {
//        
//    }

    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 10
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.row]
        let bubbleFectory = JSQMessagesBubbleImageFactory()
        if message.senderId == self.senderId {
            return bubbleFectory.outgoingMessagesBubbleImageWithColor(UIColor.blueColor())
        }
        else {
            return bubbleFectory.incomingMessagesBubbleImageWithColor(UIColor.grayColor())
        }
    }

    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let avatar = JSQMessagesAvatarImage(placeholder: UIImage(named: "anno"))
        return avatar
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let user = JZUserInfo()
        user.nickName = self.senderDisplayName
        user.uid = Int(self.senderId)!
        let message = JZMessage(user: user, text: text, date: date, type: .Message, group: group)
        messages.append(message)
        finishSendingMessageAnimated(true)
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, header headerView: JSQMessagesLoadEarlierHeaderView!, didTapLoadEarlierMessagesButton sender: UIButton!) {
        for i in 0...10 {
            let user = JZUserInfo()
            user.uid = i
            user.nickName = "user\(i)"
            let message = JZMessage(user: user, text: "earlier text \(i)", date: NSDate(), type: .Message, group: group)
            messages.insert(message, atIndex: 0)
        }
        let offset = collectionView.contentOffset
        let contentSize = collectionView.contentSize
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.contentOffset.y = collectionView.contentSize.height - (contentSize.height - offset.y)
        
    }
    
}
