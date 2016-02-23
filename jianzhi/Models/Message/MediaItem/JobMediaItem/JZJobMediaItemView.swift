//
//  JZJobMediaItemView.swift
//  jianzhi
//
//  Created by daniel on 16/2/23.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobMediaItemView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func updateData(job: JZJob) {
        titleLabel.text = job.title
        if let salary = job.salary where job.salaryType != .none {
            salaryLabel.text = "\(salary)\(job.salaryType.nameValue())"
        }
        detailLabel.text = job.detail
    }

}
