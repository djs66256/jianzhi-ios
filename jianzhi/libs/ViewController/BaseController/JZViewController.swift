//
//  JZViewController.swift
//  jianzhi
//
//  Created by daniel on 16/2/25.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        let nibName = "\(self.dynamicType)"
        if let _ = NSBundle.mainBundle().pathForResource(nibName, ofType: "nib") {
            self.init(nibName: nibName, bundle:nil)
        }
        else {
            self.init(nibName: nil, bundle: nil)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
