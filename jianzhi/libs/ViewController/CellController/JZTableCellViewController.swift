//
//  JZTableCellViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/25.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZTableCellViewController: UIViewController {
    
    var cell : UITableViewCell {
        get {
            return self.view as! UITableViewCell
        }
        set {
            self.view = newValue
        }
    }
    
    override func loadView() {
        super.loadView()
        if ((self.view as? UITableViewCell) == nil) {
            self.view = UITableViewCell()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
