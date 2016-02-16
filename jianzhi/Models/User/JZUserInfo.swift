//
//  JZUserInfo.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

enum JZUserType : Int {
    case unknow = 0
    case jobseeker = 1
    case boss = 2
}


enum JZGenderType : String {
    case male = "m", female = "f", unknow = "u"
    
    func nameValue() -> String {
        switch self {
        case .male: return "男"
        case .female: return "女"
        default : return "保密"
        }
    }
}

class JZUserInfo: NSObject, Mappable, MappableCluster {

    var uid: Int = 0
    
    var userName: String?
    
    var nickName: String?
    
    var headImage: String?
    
    var gender: JZGenderType = .unknow
    
    var userType: JZUserType = .unknow
    
    var descriptions: String?
    
    var updateTime: NSDate?
    
    var headImageUrl: NSURL? {
        if headImage != nil && !headImage!.isEmpty {
            if let urlStr = HTTP.filePath("image/head/\(headImage!)") {
                return NSURL(string: urlStr)
            }
        }
        return nil
    }
    
    override init() {
        super.init()
        uid = 0
    }
    
    init(uid:Int, userName:String) {
        super.init()
        self.uid = uid
        self.userName = userName
    }

    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        uid         <- map["id"]
        userName    <- map["name"]
        nickName    <- map["nickName"]
        gender      <- map["gender"]
        headImage   <- map["headImage"]
        userType    <- map["groupType"]
        descriptions <- map["description"]
    }
    
    static func objectForMapping(map: Map) -> Mappable? {
        let dictionary = map.JSONDictionary
        if dictionary["groupType"] as? Int == JZUserType.boss.rawValue {
            return JZBossUserInfo()
        }
        else {
            return JZJobseekerUserInfo()
        }
    }
}
