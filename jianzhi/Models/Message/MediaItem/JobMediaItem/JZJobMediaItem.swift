//
//  JZJobMediaItem.swift
//  jianzhi
//
//  Created by daniel on 16/2/23.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobMediaItem: JSQMediaItem {

    var job: JZJob?
    
    override func mediaView() -> UIView? {
        if let view = NSBundle.mainBundle().loadNibNamed("JZJobMediaItemView", owner: nil, options: nil).first as? JZJobMediaItemView, let job = job {
            view.updateData(job)
            return view
        }
        return nil
    }
    
    override func mediaViewDisplaySize() -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.width - 100, 100)
    }
}
