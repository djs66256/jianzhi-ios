//
//  JZJobListHeaderView.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobListHeaderView: UIView {

    let titleView = UILabel()
    let editButton = UIButton(type: UIButtonType.Custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleView)
        self.addSubview(editButton)
        titleView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 100))
        editButton.autoSetDimension(ALDimension.Width, toSize: 40)
        editButton.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 5)
        editButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 5)
        editButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 10)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
