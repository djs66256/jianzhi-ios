//
//  JZEducation.swift
//  jianzhi
//
//  Created by daniel on 16/1/3.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

enum JZEducationLevel : Int{
    case none                   = 0
    case other                  = 10
    case juniorSchool           = 20
    case highSchool             = 30
    case secondarySpecializedSchool = 40
    case juniorCollege          = 50
    case bachelor               = 60
    case master                 = 70
    case doctor                 = 80
    
    static let levelArray : [JZEducationLevel] = [.other, .juniorSchool, .highSchool, .secondarySpecializedSchool, .juniorCollege, .bachelor, .master, .doctor]
    
    static let nameDictionary = [
        JZEducationLevel.other : "其他",
        JZEducationLevel.juniorSchool : "初中",
        JZEducationLevel.highSchool : "高中",
        JZEducationLevel.secondarySpecializedSchool : "中专",
        JZEducationLevel.juniorCollege : "大专",
        JZEducationLevel.bachelor : "本科",
        JZEducationLevel.master : "硕士",
        JZEducationLevel.doctor : "博士"
    ]
    
    func nameValue() -> String {
        return JZEducationLevel.nameDictionary[self] ?? "未知"
    }
}

class JZEducation: NSObject, Mappable {
    
    var id: Int?
    
    var school: String?
    
    var major: String?
    
    var level: JZEducationLevel = .none
    
    var fromTime: NSDate?
    
    var toTime: NSDate?
    
    override init() {
        super.init()
    }
    
    convenience init(_ education:JZEducation) {
        self.init()
        id = education.id
        mergeFrom(education)
    }
    
    func mergeFrom(education:JZEducation) {
        school = education.school
        major = education.major
        level = education.level
        fromTime = education.fromTime
        toTime = education.toTime
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        school      <- map["school"]
        major       <- map["major"]
        level       <- map["level"]
        fromTime    <- (map["fromTime"], JZServerDateTransforms())
        toTime      <- (map["toTime"], JZServerDateTransforms())
    }
}
