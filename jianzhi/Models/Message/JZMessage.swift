//
//  JZMessage.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZMessageType : Int {
    case None = 0, Message = 1, Job = 2, Person = 3, Post = 4
}

class JZMessage: JZBaseMessage {
    
    var id: Int = 0
    var uuid: String = ""
    var fromUser: JZUserInfo?
    var toUser: JZUserInfo?
    //var text: String = ""
    //var date: NSDate
    var type : JZMessageType = .None
    var group: JZMessageGroup?
    
    var nameCard: JZUserInfo?
    var job: JZJob?
    
    var unread = true
    var uploaded = false
    
    override init() {
        super.init()
    }
    
    convenience init(fromUser: JZUserInfo, toUser: JZUserInfo, type: JZMessageType, group: JZMessageGroup) {
        self.init(fromUser: fromUser, toUser: toUser, text: "", date: NSDate(), type: type, group: group)
    }
    
    convenience init(fromUser: JZUserInfo, toUser: JZUserInfo, text: String, date: NSDate, type: JZMessageType, group: JZMessageGroup) {
        let uuid = NSUUID().UUIDString.stringByReplacingOccurrencesOfString("-", withString: "")
        self.init(id: 0, uuid: uuid, fromUser: fromUser, toUser: toUser, text: text, date: date, type: type, group: group)
    }
    
    init(id: Int, uuid: String, fromUser: JZUserInfo, toUser: JZUserInfo, text: String, date: NSDate, type: JZMessageType, group: JZMessageGroup) {
        self.id = id
        self.uuid = uuid
        self.fromUser = fromUser
        self.toUser = toUser
        self.type = type
        self.group = group
        super.init()
        self.text = text
        self.date = date
    }
    
    override var senderId: String {
        return String(fromUser!.uid)
    }
    
    override var senderDisplayName: String {
        return fromUser!.nickName ?? ""
    }
    
    override var isMediaMessage: Bool {
        return type != .Message
    }
    
    private var mediaData: JSQMessageMediaData?
    override var media: JSQMessageMediaData? {
        if let mediaData = mediaData {
            return mediaData
        }
        if type == .Job{
            let media = JZJobMediaItem()
            media.job = job
            self.mediaData = media
            return media
        }
        else if type == .Person || type == .Post {
            let media = JZNameCardMediaItem()
            media.message = self
            self.mediaData = media
            return media
        }
        return nil
    }
    
    func toSendMessage() -> JZSockMessage? {
        guard toUser != nil else { return nil }
        
        let msg = JZSockMessage()
        msg.uid = toUser!.uid
        msg.uuid = uuid
        msg.text = self.text ?? ""
        msg.type = type
        msg.jid = job?.id
        msg.cid = nameCard?.uid
        
        return msg
    }
}
