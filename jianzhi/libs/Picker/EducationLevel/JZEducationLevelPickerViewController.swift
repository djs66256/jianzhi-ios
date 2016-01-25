//
//  JZEducationLevelPickerViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/14.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZEducationLevelPickerViewControllerDelegate : NSObjectProtocol {
    func educationLevelSelected(controller:JZEducationLevelPickerViewController, level:JZEducationLevel)
}

class JZEducationLevelPickerViewController: JZPickerViewController {

    weak var delegate: JZEducationLevelPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return JZEducationLevel.levelArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return JZEducationLevel.nameDictionary[JZEducationLevel.levelArray[row]]
    }
    
    
    override func ok(sender: AnyObject) {
        super.ok(sender)
        
        delegate?.educationLevelSelected(self, level: JZEducationLevel.levelArray[pickerView.selectedRowInComponent(0)])
    }
}
