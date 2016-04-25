//
//  JZChatGroupTableViewCell.swift
//  jianzhi
//
//  Created by daniel on 16/2/22.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZChatGroupTableViewCell: JZChatBaseTableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var unreadLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        unreadLabel.layer.cornerRadius = unreadLabel.frame.width/2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(data: JZMessageGroup) {
        avatarImageView.sd_setImageWithURL(data.avatarUrl, placeholderImage: data.placeholderImage)
        nameLabel.text = data.title
        unreadLabel.text = "\(data.unread)"
        lastMessageLabel.text = data.detail
    }
    
}
