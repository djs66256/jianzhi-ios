//
//  JZFilterView.swift
//  jianzhi
//
//  Created by daniel on 16/1/24.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZFilterViewDataSource : NSObjectProtocol {
    func numberOfItems() -> Int
    func titleOfItemAtIndex(index: Int) -> String?
}

protocol JZFilterViewDelegate : NSObjectProtocol {
    func filterViewDidSelect(view: JZFilterView, index: Int)
}

class JZFilterView: UIView {
    
    weak var delegate: JZFilterViewDelegate?
    weak var dataSource: JZFilterViewDataSource?

    private var viewArray = [UIButton]()
    
    func reloadData() {
        let count: Int = dataSource?.numberOfItems() ?? 0
        for view in viewArray {
            view.removeFromSuperview()
        }
        viewArray.removeAll()
        
        for var i=0; i < count; i++ {
            let title = dataSource?.titleOfItemAtIndex(i)
            let button = newButtonView(i, count: count)
            viewArray.append(button)
            button.setTitle(title, forState: UIControlState.Normal)
        }
        
        if count > 0 {
            viewArray[0].autoPinEdgeToSuperviewEdge(ALEdge.Left)
            for var i=1; i < count; i++ {
                viewArray[i].autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: viewArray[0])
                viewArray[i].autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: viewArray[i-1])
            }
            viewArray.last?.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        }
    }
    
    func viewAtIndex(index: Int) -> UIButton? {
        if index < viewArray.count {
            return viewArray[index]
        }
        return nil
    }
    
    
    private func newButtonView(index: Int, count: Int) -> UIButton {
        let view = UIButton(type: UIButtonType.Custom)
        view.tag = index
        self.addSubview(view)
        view.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        view.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
        
        view.addTarget(self, action: Selector("titleClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        return view
    }
    
    func titleClicked(sender: UIButton) {
        delegate?.filterViewDidSelect(self, index: sender.tag)
    }
    
}
