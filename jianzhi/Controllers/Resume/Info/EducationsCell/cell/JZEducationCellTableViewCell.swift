//
//  JZEducationCellTableViewCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZEducationCellTableViewCell: UITableViewCell {
    
    var education: JZEducation?

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var marjorLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(edu: JZEducation) {
        education = edu
        
        if edu.fromTime != nil && edu.toTime != nil {
            let from = JZDateFormatter.defaultFormatter.toString(edu.fromTime!, "yyyy年MM月")
            let to = JZDateFormatter.defaultFormatter.toString(edu.toTime!, "yyyy年MM月")
            timeLabel.text = from + " - " + to
        }
        else {
            timeLabel.text = ""
        }
        schoolLabel.text = edu.school
        marjorLabel.text = edu.major
        levelLabel.text = edu.level.nameValue()
    }
    
}
