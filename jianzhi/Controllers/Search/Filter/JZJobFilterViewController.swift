//
//  JZJobFilterViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/24.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZJobFilterViewController: JZBaseFilterViewController, JZSelectAreaViewControllerDelegate {
    
    final let titles = ["地区", "类型"]
    
    var jobFilter = JZJobFilter()
    
    override var filter : JZBaseFilter {
        get {
            return jobFilter
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        jobFilter = JZJobFilter()
        filterView.backgroundColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfItems() -> Int {
        return titles.count
    }
    
    override func titleOfItemAtIndex(index: Int) -> String {
        return titles[index]
    }
    
    override func filterViewDidSelect(view: JZFilterView, index: Int) {
        if index == 0 {
            let viewController = JZSelectAreaViewController()
            viewController.showInController(self.parentViewController ?? self)
            viewController.delegate = self
        }
        else if index == 1 {
            
        }
        else {
            
        }
    }
    
    func selectArea(code: Int, area: String) {
        jobFilter.district = code
        
        delegate?.filterDidChanged(self)
    }

}
