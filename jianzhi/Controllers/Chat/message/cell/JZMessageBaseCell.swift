//
//  JZMessageBaseCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageBaseCell: UITableViewCell {
    
    var message: JZMessage?
    
    let headImageView: UIImageView = UIImageView(frame: CGRectMake(0, 0, 40, 40))

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateMessage(message:JZMessage) {
        self.message = message
        
        
    }

}
