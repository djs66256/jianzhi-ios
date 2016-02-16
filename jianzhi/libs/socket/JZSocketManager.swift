//
//  JZSocketManager.swift
//  jianzhi
//
//  Created by daniel on 16/1/28.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSocketManager: NSObject {

    static let sharedManager = JZSocketManager()
    
    var logined: Bool = false
    
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
        }
        
        socket.on("needlogin") { (data, ack) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName(JZNotification.NeedLogin, object: nil)
        }
        
        socket.on("login") { [weak self](data, ack) -> Void in
            self?.logined = true
        }
        
        socket.on("message") { (data, ack) -> Void in
            JZMessageManager.sharedManager.parse(data.first! as! String)
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
    }
    
    func sendMessage(object:AnyObject) {
        socket.emitWithAck("message", object)(timeoutAfter: UInt64(Socket.timeout)) { data in
            
        }
    }
}
