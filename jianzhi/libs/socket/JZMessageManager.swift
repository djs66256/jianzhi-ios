//
//  JZMessageManager.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZMessageReceiver : NSObjectProtocol {
    func didReceiveMessage(message: JZMessage)
}

class JZMessageManager: UIView {
    static let sharedManager = JZMessageManager()
    
    private var receivers = [JZMessageReceiver]()
    
    func addReceiver(receiver: JZMessageReceiver) {
        receivers.append(receiver)
    }
    
    func removeReceiver(receiver: JZMessageReceiver) {
        if let index = receivers.indexOf({ return receiver === $0 }) {
            receivers.removeAtIndex(index)
        }
    }
    
    func send(message: JZMessage) {
        send(message, callback: nil)
    }

    func send(message: JZMessage, callback:((Bool)->Void)?) {
        if let msg = message.toSendMessage() {
            if let toUid = message.toUser?.uid, let fromUid = message.fromUser?.uid {
                JZUserService.instance.findUserById(toUid, callback: { _ in
                    JZUserService.instance.findUserById(fromUid, callback: { _ in
                        JZSocketManager.sharedManager.sendMessage(msg, callback: callback)
                        JZMessageService.instance.insert(message)
                    })
                })
                return
            }
        }
        callback?(false)
    }
    
    func parse(data: [String: AnyObject]) -> JZSockMessage? {
        if let message = Mapper<JZSockMessage>().map(data) {
            handleMessage(message)
            
            return message
        }
        return nil
    }
    
    private func handleMessage(message: JZSockMessage) {
        JZMessageService.instance.findByUuid(message.uuid, callback: { (localMessage) -> Void in
            if localMessage == nil, let currentUid = JZUserManager.sharedManager.currentUser?.uid {
                JZUserService.instance.findUserById(currentUid, callback: { (currentUser) -> Void in
                    JZUserService.instance.findUserById(message.uid) { (user) -> Void in
                        JZMessageGroupService.instance.findGroupByReceivedMessage(message, callback: { (group) -> Void in
                            let msg = JZMessage()
                            msg.text = message.text
                            msg.type = message.type
                            msg.date = message.time
                            msg.uuid = message.uuid
                            msg.toUser = JZUserManager.sharedManager.currentUser
                            msg.fromUser = user
                            msg.group = group
                            msg.uploaded = true
                            msg.job = message.job
                            msg.nameCard = message.nameCard
                            
                            JZMessageService.instance.insert(msg)
                            self.receivers.forEach { $0.didReceiveMessage(msg) }
                            
                            // 接收者可能已经阅读过
                            if !msg.unread {
                                JZMessageService.instance.clearUnread(msg)
                            }
                            else {
                                group.unread++
                                NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.MessageGroupReload, object: nil)
                            }
                        })
                    }
                })
            }
            else {
                
            }
        })
    }
    
    func uploaded(uuid: String) {
        JZMessageService.instance.setUploaded(uuid)
    }
    
    func error(uuid: String) {
        JZMessageService.instance.removeByUuid(uuid)
    }

}
