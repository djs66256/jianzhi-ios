//
//  JZDetailUserInfoViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZDetailUserInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationItem.title = "个人信息"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func inviteClicked(sender: AnyObject) {
        let viewController = JZInviteTableViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
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
