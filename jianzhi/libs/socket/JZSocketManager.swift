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
    
    private let socket = SocketIOClient(socketURL: Socket.url(), options: options)
    
    private override init() {
        super.init()
        
        initListener()
    }
    
    private func initListener() {
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
            if let jsons = data[0] as? [[String:AnyObject]] {
                var uuids = [String]()
                jsons.forEach {
                    if let message = JZMessageManager.sharedManager.parse($0) {
                        uuids.append(message.uuid)
                    }
                }
                
                if !uuids.isEmpty {
//                    socket.emitWithAck("messageAck", uuids)
                }
            }
            else if let json = data[0] as? [String:AnyObject] {
                if let message = JZMessageManager.sharedManager.parse(json) {
                    
                }
            }
        }
        
        socket.on("messageAck") { (data, ack) -> Void in
            if let uuids = data[0] as? [String] {
                uuids.forEach {
                    JZMessageManager.sharedManager.uploaded($0)
                }
            }
            else if let uuid = data[0] as? String {
                JZMessageManager.sharedManager.uploaded(uuid)
            }
        }
        
        socket.on("messageError") { (data, ack) -> Void in
            if let uuids = data as? [String] {
                uuids.forEach {
                    JZMessageManager.sharedManager.error($0)
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
    }
    
    func sendMessage(message:JZSockMessage) {
        let json = message.toJSON()
        socket.emitWithAck("message", json)(timeoutAfter: UInt64(Socket.timeout)) { data in
            
        }
        
    }
}
