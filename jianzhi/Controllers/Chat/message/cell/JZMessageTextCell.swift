//
//  JZMessageTextCell.swift
//  jianzhi
//
//  Created by daniel on 16/1/2.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMessageTextCell: JZMessageBaseCell {

    let messageLabel: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        messageContentView.addSubview(messageLabel)
        messageLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(2, 5, 2, 5))
        messageLabel.backgroundColor = UIColor.redColor()
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFontOfSize(14)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func heightForMessage(message: JZMessage, width: CGFloat) -> CGFloat {
        if let text: NSString = message.content?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) {
            let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(14)]
            let rect = text.boundingRectWithSize(CGSizeMake(width, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: attributes, context: nil)
            
            let height = 15 + rect.height
            if height < 60 {
                return 60
            }
            else {
                return height
            }
        }
        return 14
    }

    override func updateMessage(message:JZMessage) {
        super.updateMessage(message)
        
        messageLabel.text = message.content
    }
}
