//
//  JZJobListCellTableViewCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobListCellTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    var job: JZJob?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(job:JZJob) {
        self.job = job
        titleLabel.text = job.title
        if job.salary > 0 && job.salaryType != .none {
            salaryLabel.text = String(job.salary!) + (job.salaryType.nameValue() ?? "")
        }
        else {
            salaryLabel.text = ""
        }
    }
    
}
