//
//  JZSalaryTypePickerViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/14.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZSalaryTypePickerViewControllerDelegate : NSObjectProtocol {
    func salaryTypeSelected(viewController:JZSalaryTypePickerViewController, type:JZSalaryTypeBy)
}

struct JZSalaryTypeDataSource {
    var name: String!
    var type: JZSalaryTypeBy!
}

class JZSalaryTypePickerViewController: JZPickerViewController {

    weak var delegate : JZSalaryTypePickerViewControllerDelegate?
    
    var dataSource = [JZSalaryTypeDataSource(name: "每月", type: .month),
        JZSalaryTypeDataSource(name: "每天", type: .day),
        JZSalaryTypeDataSource(name: "每小时", type: .hour),
        JZSalaryTypeDataSource(name: "一次性", type: .once)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let typeData = dataSource[row]
        return typeData.name
    }
    
    
    override func ok(sender: AnyObject) {
        super.ok(sender)
        
        let type = dataSource[pickerView.selectedRowInComponent(0)].type
        delegate?.salaryTypeSelected(self, type: type)
    }

}
