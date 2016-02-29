//
//  JZSocketManager.swift
//  jianzhi
//
//  Created by daniel on 16/1/28.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZSocketState {
    case Unconnect, Connect, Logined
}

class JZSocketManager: NSObject {

    static let sharedManager = JZSocketManager()
    
    var status = JZSocketState.Unconnect
    
    private static let options = [
        "reconnects": true,
        "forceWebsockets":true,
        "reconnectWait":10,
//        "log":true
    ]
    
    private var socket = SocketIOClient(socketURL: Socket.url(), options: options)
    
    private override init() {
        super.init()
        initSocket()
    }
    
    private func initSocket() {
        socket.on("connect") { (data, ack) -> Void in
            JZLogInfo("[SOCK] connect")
            self.status = .Connect
        }
        
        socket.on("disconnect") { (data, ack) -> Void in
            self.status = .Unconnect
        }
        
        socket.on("needlogin") { (data, ack) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.NeedLogin, object: nil)
        }
        
        socket.on("login") { (data, ack) -> Void in
            self.status = .Logined
        }
        
        socket.on("message") { (data, ack) -> Void in
            ack.with("ok")
            if let jsons = data.first as? [[String:AnyObject]] {
//                var uuids = [String]()
                jsons.forEach {
                    if let message = JZMessageManager.sharedManager.parse($0) {
//                        uuids.append(message.uuid)
                    }
                }
            }
            else if let json = data.first as? [String:AnyObject] {
                if let message = JZMessageManager.sharedManager.parse(json) {
//                    self.socket.emit("messageAck", message.uuid)
                }
            }
        }
        
    }

    func connect() {
        if let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(Socket.url()) {
            if cookies.count > 0 {
                socket.options.insert(.Cookies(cookies))
                socket.connect(timeoutAfter: Socket.timeout) { () -> Void in
                    
                }
            }
        }
    }
    
    func reconnect() {
        let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(Socket.url())
        if cookies != nil {
            socket.options.insert(.Cookies(cookies!))
            socket.reconnect()
        }
    }
    
    func disconnect() {
        socket.disconnect()
        status = .Unconnect
        
        socket = SocketIOClient(socketURL: Socket.url(), options: JZSocketManager.options)
        initSocket()
    }
    
    func sendMessage(message:JZSockMessage) {
        sendMessage(message, callback: nil)
    }
    
    func sendMessage(message:JZSockMessage, callback:((Bool)->Void)?) {
        let json = message.toJSON()
        socket.emitWithAck("message", json)(timeoutAfter: UInt64(Socket.timeout)) { (data) -> Void in
            if let ret = data.first as? String {
                if ret == "ok" {
                    JZMessageManager.sharedManager.uploaded(message.uuid)
                    callback?(true)
                }
                else {
                    JZMessageManager.sharedManager.error(message.uuid)
                    callback?(false)
                }
            }
        }
    }
}
