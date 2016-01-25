//
//  JZGenderTableViewCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/7.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZGenderTableViewCell: UITableViewCell {
    
    @IBOutlet var male : UIButton!
    
    @IBOutlet var female : UIButton!
    
    @IBOutlet var unknow : UIButton!
    
    var genderType : JZGenderType {
        get {
            if male.selected {
                return JZGenderType.male
            }
            else if female.selected {
                return JZGenderType.female
            }
            else {
                return JZGenderType.unknow
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        male.addTarget(self, action: Selector("genderselect:"), forControlEvents: UIControlEvents.TouchUpInside)
        female.addTarget(self, action: Selector("genderselect:"), forControlEvents: UIControlEvents.TouchUpInside)
        unknow.addTarget(self, action: Selector("genderselect:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func genderselect(sender: UIButton?) {
        male.selected = false
        female.selected = false
        unknow.selected = false
        
        if sender == male {
            male.selected = true
        }
        if sender == female {
            female.selected = true
        }
        if sender == unknow {
            unknow.selected = true
        }
    }

}
