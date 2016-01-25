//
//  JZIdentifyingCodeCellTableViewCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/13.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZIdentifyingCodeCellTableViewCell: JZTextFieldTableViewCell {
    
    @IBOutlet var button : JZTimerButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
