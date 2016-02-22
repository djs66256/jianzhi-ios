//
//  JZMessageViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/31.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageViewController: JSQMessagesViewController, JZMessageReceiver {
    
    var messages = [JZMessage]()
    var group = JZMessageGroup()
    var page = 0
    
    init(group: JZMessageGroup) {
        super.init(nibName: nil, bundle: nil)
        self.group = group
        
        JZMessageManager.sharedManager.addReceiver(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        JZMessageManager.sharedManager.removeReceiver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        if let userid = JZUserManager.sharedManager.currentUser?.uid {
            self.senderId = String(userid)
        }
        else {
            self.senderId = "0"
        }
        self.senderDisplayName = JZUserManager.sharedManager.currentUser?.nickName ?? ""

        loadMessages()
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
        if message.fromUser?.uid == JZUserManager.sharedManager.currentUser?.uid {
            return bubbleFectory.outgoingMessagesBubbleImageWithColor(UIColor.blueColor())
        }
        else {
            return bubbleFectory.incomingMessagesBubbleImageWithColor(UIColor.grayColor())
        }
    }

    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
        if let cell = cell as? JSQMessagesCollectionViewCell {
            if let placeholder = UIImage(named: "anno") {
                cell.avatarImageView?.sd_setImageWithURL(messages[indexPath.row].fromUser?.avatarUrl, placeholderImage: placeholder)
            }
        }
        return cell
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        if let user = JZUserManager.sharedManager.currentUser, let toUser = group.user {
            let message = JZMessage(fromUser: user, toUser: toUser, text: text, date: date, type: .Message, group: group)
            message.unread = false
//            JZMessageService.instance.save(message)
            JZMessageManager.sharedManager.send(message)
            
            messages.append(message)
            finishSendingMessageAnimated(true)
        }
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, header headerView: JSQMessagesLoadEarlierHeaderView!, didTapLoadEarlierMessagesButton sender: UIButton!) {
        page++
        loadMessages()
//        for i in 0...10 {
//            let user = JZUserInfo()
//            user.uid = i
//            user.nickName = "user\(i)"
//            let message = JZMessage(fromUser: user, text: "earlier text \(i)", toUser: date: NSDate(), type: .Message, group: group)
//            messages.insert(message, atIndex: 0)
//        }
        
    }
    
//    - (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath;
//    func collectionView
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapAvatarImageView avatarImageView: UIImageView!, atIndexPath indexPath: NSIndexPath!) {
        let msg = messages[indexPath.row]
        
        if let user = msg.fromUser {
            switch user.userType {
            case .boss:
                let controller = JZBossInfoTableViewController()
                controller.userId = user.uid
                navigationController?.pushViewController(controller, animated: true)
            case .jobseeker:
                let controller = JZJobSeekerTableViewController()
                controller.userId = user.uid
                navigationController?.pushViewController(controller, animated: true)
            default: return
            }
        }
    }
    
    private func loadMessages() {
        JZMessageService.instance.findByGroup(group, index: page*kJZMessageQueryCount, count: kJZMessageQueryCount) { messages in
            
            if self.messages.count == 0 {
                self.messages.insertContentsOf(messages, at: 0)
                self.collectionView?.reloadData()
            }
            else {
                self.messages.insertContentsOf(messages, at: 0)
                let offset = self.collectionView!.contentOffset
                let contentSize = self.collectionView!.contentSize
                self.collectionView?.reloadData()
                self.collectionView?.layoutIfNeeded()
                self.collectionView?.contentOffset.y = self.collectionView!.contentSize.height - (contentSize.height - offset.y)
            }
            
            self.scrollToBottomAnimated(true)
            
            if messages.count < kJZMessageQueryCount {
                self.showLoadEarlierMessagesHeader = false
            }
            else {
                self.showLoadEarlierMessagesHeader = true
            }
        }
    }
    
    func didReceiveMessage(message: JZMessage) {
        if message.fromUser?.uid == group.user?.uid {
            messages.append(message)
            finishReceivingMessageAnimated(true)
            JZMessageService.instance.clearUnread(message)
        }
    }
    
}
