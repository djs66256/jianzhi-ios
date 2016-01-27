//
//  JZPickerViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/7.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZPickerViewController: JZActionSheetViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var tagString : String?
    
//    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerComponentView: JZPickerComponentView!
    
    var pickerView : UIPickerView {
        get {
            return pickerComponentView.pickerView
        }
    }
    
    override func loadView() {
        pickerComponentView = (NSBundle.mainBundle().loadNibNamed("JZPickerComponentView", owner: nil, options: nil)[0] as? JZPickerComponentView) ?? JZPickerComponentView()
        self.contentView = pickerComponentView
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerComponentView.pickerView.delegate = self
        pickerComponentView.pickerView.dataSource = self
        pickerComponentView.okButton.addTarget(self, action: Selector("ok:"), forControlEvents: UIControlEvents.TouchUpInside)
        pickerComponentView.cancelButton.addTarget(self, action: Selector("cancel:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 0
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    // MARK: -
    
    @IBAction func cancel(sender: AnyObject) {
        dismiss()
    }
    
    
    @IBAction func ok(sender: AnyObject) {
        dismiss()
    }

}
