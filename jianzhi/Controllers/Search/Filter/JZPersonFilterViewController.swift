//
//  JZPersonFilterViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/26.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZPersonFilterViewController: JZBaseFilterViewController, JZEducationLevelPickerViewControllerDelegate {

    let titles = ["学历"]
    
    var personFilter = JZPersonFilter()
    
    override var filter : JZBaseFilter {
        return personFilter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        filterView.backgroundColor = UIColor.orangeColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func numberOfItems() -> Int {
        return titles.count
    }
    
    override func titleOfItemAtIndex(index: Int) -> String? {
        return titles[index]
    }
    
    override func filterViewDidSelect(view: JZFilterView, index: Int) {
        if index == 0 {
            let viewController = JZEducationLevelPickerViewController()
            viewController.delegate = self
            viewController.showInController(self)
        }
    }
    
    func educationLevelSelected(controller: JZEducationLevelPickerViewController, level: JZEducationLevel) {
        personFilter.educationLevel = level
        delegate?.filterDidChanged(self)
    }

}
