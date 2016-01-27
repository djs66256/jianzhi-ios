//
//  JZActionSheet.swift
//  jianzhi
//
//  Created by daniel on 16/1/27.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZActionSheetViewController: JZAlertViewController {
    
    @IBOutlet var contentView: UIView?
    
    private var contentViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if contentView != nil {
            self.view.addSubview(contentView!)
            
            self.contentView!.autoPinEdgeToSuperviewEdge(.Left)
            self.contentView!.autoPinEdgeToSuperviewEdge(.Right)
            self.contentView!.autoSetDimension(.Height, toSize: self.contentView!.frame.height)
            contentViewBottomConstraint = self.contentView!.autoPinEdgeToSuperviewEdge(.Bottom, withInset: -self.contentView!.frame.height)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if animated {
            self.contentView?.layoutIfNeeded()
            if contentView != nil && contentViewBottomConstraint != nil {
                UIView.animateWithDuration(0.3) {
                    self.contentViewBottomConstraint!.constant = 0
                    self.contentView?.layoutIfNeeded()
                }
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if animated {
            if contentView != nil && contentViewBottomConstraint != nil {
                UIView.animateWithDuration(0.3) {
                    self.contentViewBottomConstraint!.constant = self.contentView!.frame.height
                    self.contentView?.layoutIfNeeded()
                }
            }
        }
    }

}
