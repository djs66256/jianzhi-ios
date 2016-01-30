//
//  JZMessageMyTextCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/30.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageMyTextCell: JZMessageTextCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImageButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
