//
//  JZMessageEditView.swift
//  jianzhi
//
//  Created by daniel on 16/1/30.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZMessageEditViewDelegate : NSObjectProtocol {
    func messageEditViewFrameDidChange(view: JZMessageEditView, to: CGFloat, duration:NSTimeInterval)
}

class JZMessageEditView: UIView, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
//    @IBOutlet weak var editView: UIView!
//    @IBOutlet weak var keyboardContentView: UIView!
    
    @IBOutlet var heightConstraint: NSLayoutConstraint?
  
    
}
