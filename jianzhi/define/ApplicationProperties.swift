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
    
    struct Socket {
        static let address = HTTP.ip //"localhost"
        static let port    = 3000
        static let timeout = 60
        
        static func url() -> NSURL {
            return NSURL(string: "http://\(address):\(port)")!
        }
    }
    
    struct HTTP {
        static let ip = "localhost" //"192.168.1.104"
        static let port = 8080
        static let location = "\(HTTP.ip):\(HTTP.port)"
        
        static func filePath(file: String?) -> String? {
            if file != nil {
                return "http://\(self.location)/file/\(file!)"
            }
            return nil
        }
    }
    
    struct WEB {
        static let host = "localhost"
        static let port = ""
        static let path = "http://\(WEB.host)"
    }
    
#else
    
#endif

let kJZHeadImageSize = 128 // px
let kJZMessageQueryCount = 20