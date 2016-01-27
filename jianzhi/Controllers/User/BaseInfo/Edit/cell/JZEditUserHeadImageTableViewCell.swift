//
//  JZEditUserHeadImageTableViewCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/27.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZEditUserHeadImageTableViewCell: UITableViewCell {

    @IBOutlet var headImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headImageView.layer.cornerRadius = 4
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
