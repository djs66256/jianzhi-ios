//
//  JZWorkExperiencesCellTableViewCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZWorkExperiencesCellTableViewCell: UITableViewCell {

    var workExperience: JZWorkExperience?
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(work: JZWorkExperience) {
        workExperience = work
        
        if work.fromTime != nil && work.toTime != nil {
            let from = JZDateFormatter.defaultFormatter.toString(work.fromTime!, "yyyy年MM月")
            let to = JZDateFormatter.defaultFormatter.toString(work.toTime!, "yyyy年MM月")
            timeLabel.text = from + " - " + to
        }
        else {
            timeLabel.text = ""
        }
        
        companyLabel.text = work.companyName
        positionLabel.text = work.position
        descriptionLabel.text = work.descriptions
    }
    
}
