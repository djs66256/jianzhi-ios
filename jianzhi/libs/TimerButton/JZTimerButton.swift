//
//  JZTimerButton.swift
//  jianzhi
//
//  Created by daniel on 16/1/7.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZTimerButton: UIButton {

    var timer : NSTimer?
    
    var maxTimeInterval = 60
    
    var tick = 60
    
    var originalTitle : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addTarget(self, action: Selector("timerStart"), forControlEvents: UIControlEvents.TouchUpInside)
        
        originalTitle = self.titleForState(UIControlState.Normal)
    }
    
    func beginTick() {
        tick = maxTimeInterval
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("doTimer"), userInfo: nil, repeats: true)
        
        self.userInteractionEnabled = false
    }
    
    func endTick() {
        self.userInteractionEnabled = true
        self.setTitle(originalTitle, forState: UIControlState.Normal)
        timer?.invalidate()
    }

    func timerStart() {
        beginTick()
    }
    
    func doTimer() {
        if tick > 0 {
            self.setTitle("\(tick)", forState: UIControlState.Normal)
            tick--
        }
        else {
            endTick()
        }
    }
}
