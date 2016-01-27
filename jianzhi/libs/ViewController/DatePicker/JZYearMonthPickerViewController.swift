//
//  JZYearMonthPickerViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/7.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZYearMonthPickerViewControllerDelegate : NSObjectProtocol {
    func yearMonthPicker(controller: JZYearMonthPickerViewController, _ data: NSDate?, _ year: Int, _ month: Int)
}

class JZYearMonthPickerViewController: JZPickerViewController {
    
    weak var delegate : JZYearMonthPickerViewControllerDelegate?
    
    var minYear = 1970
    var maxYear = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: NSDate()).year

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - picker delegate
    
    override func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    override func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return maxYear - minYear + 1
        }
        else {
            return 12
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(maxYear - row)"
        }
        else {
            return "\(row + 1)"
        }
    }
    
    @IBAction override func ok(sender: AnyObject) {
        let components = NSDateComponents()
        components.year = maxYear - pickerView.selectedRowInComponent(0)
        components.month = pickerView.selectedRowInComponent(1) + 1
        let date = NSCalendar.currentCalendar().dateFromComponents(components)
        
        delegate?.yearMonthPicker(self, date, components.year, components.month)
        
        dismiss()
    }

}
