//
//  JZAlertViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/7.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZAlertViewController: JZViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if #available(iOS 8.0, *) {
            self.modalPresentationStyle = .Custom
            self.modalTransitionStyle = .CrossDissolve
        } else {
            self.modalPresentationStyle = .CurrentContext
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let gesture = UITapGestureRecognizer(target: self, action: Selector("dismiss"))
//        self.view.addGestureRecognizer(gesture)
        
        let button = UIButton()
        button.addTarget(self, action: Selector("dismiss"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.insertSubview(button, atIndex: 0)
        button.autoPinEdgesToSuperviewEdges()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showInController(controller: UIViewController) {
        controller.definesPresentationContext = true
        controller.providesPresentationContextTransitionStyle = true
        
        controller.presentViewController(self, animated: true, completion: nil)
    }
    
    func dismiss(completion:(()->Void)?) {
        self.dismissViewControllerAnimated(true, completion: completion)
    }
    
    func dismiss() {
        dismiss(nil)
    }

}
