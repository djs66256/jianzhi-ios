//
//  JZDatePickerViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/7.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZDatePickerViewController: JZActionSheetViewController {
    
    var pickComponent: JZDatePickerComponentView? {
        return contentView as? JZDatePickerComponentView
    }
    
    var dataPicker: UIDatePicker? {
        return pickComponent?.pickerView
    }

    override func viewDidLoad() {
        if let view = NSBundle.mainBundle().loadNibNamed("JZDatePickerComponentView", owner: nil, options: nil).first as? JZDatePickerComponentView {
            view.cancelButton.addTarget(self, action: Selector("cancel:"), forControlEvents: .TouchUpInside)
            view.okButton.addTarget(self, action: Selector("ok:"), forControlEvents: .TouchUpInside)
            contentView = view
        }
        
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
