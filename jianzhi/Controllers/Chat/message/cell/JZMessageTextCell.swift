//
//  JZMessageTextCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageTextCell: JZMessageBaseCell {

    let messageLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    let messageBackgroundImageView: UIImageView = UIImageView(frame: CGRectMake(0, 0, 300, 40))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
