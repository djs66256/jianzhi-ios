//
//  JZResume.swift
//  jianzhi
//
//  Created by daniel on 16/1/3.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZResume: NSObject, Mappable {
    
    var id : Int?
    
    var user : JZJobseekerUserInfo?
    
    var descriptions : String?
    
    var expectJob : String?
    
    var expectSalary : Int?
    
    var educationLevel : Int = 0
    
    var salaryType : JZSalaryTypeBy?
    
    var educations : [JZEducation]?
    
    var workExperiences : [JZWorkExperience]?
    
    override init() {
        
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        descriptions    <- map["description"]
        expectJob       <- map["expectJob"]
        expectSalary    <- map["expectSalary"]
        educationLevel  <- map["educationLevel"]
        salaryType      <- map["salaryType"]
        
        educations      <- map["educations"]
        workExperiences <- map["workExperiences"]
    }
    
    
}
