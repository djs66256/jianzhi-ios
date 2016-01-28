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
    
    private static let options = [
        "reconnects": true,
        "forceWebsockets":true,
        "reconnectWait":10,
//        "log":true
    ]
    
    private let socket = SocketIOClient(socketURL: Socket.url(), options: options)
    
    private override init() {
        super.init()
        
        socket.on("connect") { (data, ack) -> Void in
            JZLogInfo("[SOCK] connect")
        }
    }

    func connect() {
        let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(Socket.url())
        if cookies != nil {
            socket.options.insert(.Cookies(cookies!))
            socket.connect(timeoutAfter: Socket.timeout) { () -> Void in
                
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
    
    func send() {
        socket.emit("message", ["lalala":"fff"])
    }
}
