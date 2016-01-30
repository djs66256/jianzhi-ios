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
    
    let headImageButton: UIButton = UIButton(type: .Custom)
    let messageContentView = UIView()
    let messageBackgroundImageView = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        
        contentView.addSubview(headImageButton)
        headImageButton.layer.cornerRadius = 4
        headImageButton.layer.borderWidth = 0.5
        headImageButton.layer.borderColor = UIColor(white: 0.5, alpha: 1).CGColor
        headImageButton.autoSetDimensionsToSize(CGSizeMake(40,40))
        headImageButton.autoPinEdgeToSuperviewEdge(.Top, withInset: 5)
        
        contentView.addSubview(messageContentView)
        messageContentView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(5, 50, 5, 50))
        
        messageContentView.addSubview(messageBackgroundImageView)
        messageBackgroundImageView.autoPinEdgesToSuperviewEdges()
        messageBackgroundImageView.backgroundColor = UIColor(white: 0.5, alpha: 1)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        let placeholderImage = UIImage(named: "anno")
        if let headUrl = message.user?.headImageUrl {
            headImageButton.setImageForState(.Normal, withURL: headUrl, placeholderImage: placeholderImage)
        }
        else {
            headImageButton.setImage(placeholderImage, forState: .Normal)
        }
        
    }
    
    class func heightForMessage(message:JZMessage, width: CGFloat) -> CGFloat {
        return 0
    }

}
