//
//  JZNameCardMediaItem.swift
//  jianzhi
//
//  Created by daniel on 16/2/24.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZNameCardMediaItem: JSQMediaItem {
    
    weak var message: JZMessage?

    override func mediaView() -> UIView? {
        if let view = NSBundle.mainBundle().loadNibNamed("JZNameCardMediaItemView", owner: nil, options: nil).first as? JZNameCardMediaItemView, let message = message {
            view.updateData(message)
            return view
        }
        return nil
    }
    
    override func mediaViewDisplaySize() -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.width - 100, 100)
    }
}
