//
//  ApplicationProperties.h
//  jianzhi
//
//  Created by daniel on 15/12/26.
//  Copyright © 2015年 jianzhi. All rights reserved.
//

#if DEBUG
    
    struct BaiduMap{
        static let accessKey = "MVZVRMg3H5dFSG416avM53Xw"
    }
    
    struct Soket {
        static let address = "localhost"
        static let port    = 3333
        static let timeout = 60
    }
    
    struct HTTP {
        static let ip = "192.168.1.104"
        static let port = 8080
        static let location = "\(HTTP.ip):\(HTTP.port)"
    }
    
    struct WEB {
        static let host = "localhost"
        static let port = ""
        static let path = "http://\(WEB.host)"
    }
    
#else
    
#endif