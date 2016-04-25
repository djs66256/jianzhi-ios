//
//  JZMessageViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/31.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageViewController: JSQMessagesViewController, JZMessageReceiver, JZSelectJobListTableViewControllerDelegate {
    
    let jobCellIdentifier = "job"
    
    var messages = [JZMessage]()
    var group = JZMessageGroup()
    var page = 0
    
    init(group: JZMessageGroup) {
        super.init(nibName: nil, bundle: nil)
        self.group = group
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        collectionView?.registerNib(UINib(nibName: "JZJobMessageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:jobCellIdentifier)
        
        loadMessages()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        JZMessageManager.sharedManager.addReceiver(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        JZMessageManager.sharedManager.removeReceiver(self)
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
        let message = messages[indexPath.row]
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        if let placeholder = UIImage(named: "anno") {
            cell.avatarImageView?.sd_setImageWithURL(messages[indexPath.row].fromUser?.avatarUrl, placeholderImage: placeholder)
        }
        return cell
        
//        switch message.type {
//        case .Job:
//            //            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(jobCellIdentifier, forIndexPath: indexPath) as! JZJobMessageCollectionViewCell
//            if let job = message.job {
//                let text = "\(job.title ?? "")\n\(job.detail ?? "")\n\(job.salary)\(job.salaryType.nameValue())"
//                cell.textView?.text = text
//            }
//            return cell
//        default:
//            
//            return cell
//        }
        
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
        inputToolbar?.contentView?.textView?.resignFirstResponder()
        
        if JZUserManager.sharedManager.currentUser?.userType == .boss {
            let controller = JZSelectJobListTableViewController()
            controller.delegate = self
            navigationController?.pushViewController(controller, animated:true)
        }
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
    
//    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let message = messages[indexPath.row]
//        switch message.type {
//        case .Job:
//            return CGSizeMake(collectionView.frame.width - 40, 100)
//        default:
//            return super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAtIndexPath: indexPath)
//        }
//
//    }
//    
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
    
    func didSelectJob(controller: JZSelectJobListTableViewController, job: JZJob) {
        controller.navigationController?.popViewControllerAnimated(true)
        if let user = JZUserManager.sharedManager.currentUser, let toUser = group.user {
            let message = JZMessage(fromUser: user, toUser: toUser, type: .Job, group: group)
            message.job = job
            message.unread = false
            
            JZMessageManager.sharedManager.send(message)
        }
    }
    
}
