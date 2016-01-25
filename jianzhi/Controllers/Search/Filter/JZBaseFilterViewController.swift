//
//  JZBaseFilterViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/24.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZBaseFilterViewControllerDelegate: NSObjectProtocol {
    func filterDidChanged(viewController:JZBaseFilterViewController)
}

class JZBaseFilterViewController: UIViewController, JZFilterViewDelegate, JZFilterViewDataSource {
    
    weak var delegate: JZBaseFilterViewControllerDelegate?
    
    var filter : JZBaseFilter? {
        return nil
    }
    
    var filterView : JZFilterView! {
        get {
            return self.view as! JZFilterView
        }
    }
    
    override func loadView() {
        let filterView = JZFilterView()
        view = filterView
        filterView.delegate = self
        filterView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.filterView.reloadData()
        
        view.autoSetDimension(ALDimension.Height, toSize: 40)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItems() -> Int {
        return 0
    }
    
    func titleOfItemAtIndex(index: Int) -> String? {
        return nil
    }
    
    func filterViewDidSelect(view: JZFilterView, index: Int) {
        
    }

}
