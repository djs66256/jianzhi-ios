//
//  JZJobSearchTableCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobSearchTableCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func updateData(data:JZSearchJobItem) {
        titleLabel.text = data.title
        if data.time != nil {
            timeLabel.text = JZDateFormatter.defaultFormatter.toString(data.time!, "发布于yyyy年mm月dd日")
        }
    }
}
