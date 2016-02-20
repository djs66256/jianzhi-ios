//
//  JZLocationDataBase.swift
//  jianzhi
//
//  Created by daniel on 16/1/17.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZLocationDataBase: JZDataBase {
    static let sharedDataBase = JZLocationDataBase()

    init() {
        if let path = NSBundle.mainBundle().pathForResource("location", ofType: "sqlite") {
            super.init(path: path)
        }
        else {
            JZLogError("DB File does not exist")
            super.init(path: "")
        }
    }
    
    func findAllProvice(block:([JZProvince])->Void) {
        self.queryAll("SELECT * FROM province;", callback: block)
    }
    
    func findCity(province:JZProvince, block:([JZCity])->Void) {
        execuse {
            let result = self.db.executeQuery("SELECT id, city FROM city WHERE provinceId = ?;", withArgumentsInArray: [province.id]);
            var cityList = [JZCity]()
            if result != nil {
                while result.next() {
                    let id = result.intForColumn("id")
                    let cityName = result.stringForColumn("city")
                    let city = JZCity(id: Int(id), city: cityName)
                    city.province = province
                    cityList.append(city)
                }
            }
            self.callback {
                block(cityList)
            }
        }
    }
    
    func findDistrict(city:JZCity, block:([JZDistrict])->Void) {
        execuse {
            let result = self.db.executeQuery("SELECT id, district FROM district WHERE cityId = ?;", withArgumentsInArray: [city.id]);
            var districtList = [JZDistrict]()
            if result != nil {
                while result.next() {
                    let id = result.intForColumn("id")
                    let districtName = result.stringForColumn("district")
                    let district = JZDistrict(id: Int(id), district: districtName)
                    district.city = city
                    districtList.append(district)
                }
            }
            self.callback {
                block(districtList)
            }
        }
    }
}
