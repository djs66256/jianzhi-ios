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
        if let msg = message.toSendMessage() {
            JZSocketManager.sharedManager.sendMessage(msg)
            JZMessageService.instance.insert(message)
        }
    }
    
    func parse(data: [String: AnyObject]) -> JZSockMessage? {
        if let message = Mapper<JZSockMessage>().map(data) {
            JZMessageService.instance.findByUuid(message.uuid, callback: { (localMessage) -> Void in
                if localMessage == nil {
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
                            
                            JZMessageService.instance.insert(msg)
                            self.receivers.forEach { $0.didReceiveMessage(msg) }
                        })
                    }
                }
            })
            
            return message
        }
        return nil
    }
    
    func uploaded(uuid: String) {
        JZMessageService.instance.setUploaded(uuid)
    }
    
    func error(uuid: String) {
        JZMessageService.instance.removeByUuid(uuid)
    }

}
