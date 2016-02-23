//
//  JZSelectJobListTableViewCell.swift
//  jianzhi
//
//  Created by daniel on 16/2/23.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZSelectJobListTableViewCell: UITableViewCell {

    var job: JZJob?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(job: JZJob) {
        self.job = job
        textLabel?.text = job.title
        detailTextLabel?.text = job.detail
    }
    
}
