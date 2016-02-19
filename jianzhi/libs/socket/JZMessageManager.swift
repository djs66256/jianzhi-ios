//
//  JZMessageManager.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZMessageReceiver : NSObjectProtocol {
    func didReceiveMessage(message: JZSockMessage)
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
            JZMessageService.instance.save(message)
        }
    }
    
    func parse(data: [String: AnyObject]) -> JZSockMessage? {
        if let message = Mapper<JZSockMessage>().map(data) {
            receivers.forEach({ $0.didReceiveMessage(message) })
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
