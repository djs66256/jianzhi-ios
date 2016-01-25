//
//  JZMainViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMainViewController: UITabBarController {
    
    let mapViewController = UINavigationController(rootViewController: JZMapViewController())
    let searchViewController = UINavigationController(rootViewController: JZSearchViewController())
    let chatViewControlelr = UINavigationController(rootViewController: JZChatViewController())
    let meViewController = UINavigationController(rootViewController: JZMeViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        mapViewController.tabBarItem.title = "map"
        searchViewController.tabBarItem.title = "search"
        chatViewControlelr.tabBarItem.title = "chat"
        meViewController.tabBarItem.title = "me"
        
        self.viewControllers = [mapViewController, searchViewController, chatViewControlelr, meViewController];
        
        
       
    }
    
    static var isLogin : Bool = false
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        if !JZUserManager.sharedManager.isLogin {
        if !JZMainViewController.isLogin {
            JZMainViewController.isLogin = true
            let loginController = JZLoginTableViewController()
            self.presentViewController(UINavigationController(rootViewController: loginController), animated: true, completion: nil)
        }
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
