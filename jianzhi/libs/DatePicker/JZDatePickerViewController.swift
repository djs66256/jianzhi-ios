//
//  JZDatePickerViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/7.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZDatePickerViewController: JZAlertViewController {
    
    @IBOutlet weak var dataPicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(sender: AnyObject) {
        dismiss()
    }
    
    @IBAction func ok(sender: AnyObject) {
    }
}
