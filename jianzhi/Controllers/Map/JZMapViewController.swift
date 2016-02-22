//
//  JZMapViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMapViewController: UIViewController, BMKGeneralDelegate, BMKMapViewDelegate {

    let personAnnotationIdentifier = "person"
    let companyAnnotationIdentifier = "company"
    
    @IBOutlet weak var mapView: BMKMapView!
    private let mapManager = BMKMapManager()
    
    
    convenience init() {
        self.init(nibName: "JZMapViewController", bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        mapManager.start(BaiduMap.accessKey, generalDelegate: self)
        self.navigationItem.title = "Map"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "select", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("selectMap"))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        let annotation = JZMapAnnotation()
//        annotation.coordinate = CLLocationCoordinate2DMake(39.915, 116.404)
//        annotation.title = "title"
//        annotation.subtitle = "subtitle"
//        mapView.addAnnotation(annotation)
//        
        JZSearchViewModel.mapSearch({ (annotations) -> Void in
            self.mapView.addAnnotations(annotations)
            }, failure: {
                JZAlertView.show($0)
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.delegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: map view delegate
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        
        if let annotation = annotation as? JZPersonMapAnnotation {
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(personAnnotationIdentifier)
            if annotationView == nil {
                annotationView = JZMapUserAnnotationView(annotation: annotation, reuseIdentifier: personAnnotationIdentifier)
            }
            return annotationView
        }
        else if let annotation = annotation as? JZCompanyMapAnnotation {
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(companyAnnotationIdentifier)
            if annotationView == nil {
                annotationView = JZMapCompanyAnnotationView(annotation: annotation, reuseIdentifier: companyAnnotationIdentifier)
            }
            return annotationView
        }
        
        return JZMapAnnotationView(annotation: annotation, reuseIdentifier: "")
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
//        if let anno = view.annotation as? JZPersonMapAnnotation {
//            let controller = JZMyJobSeekerTableViewController()
//            
//            navigationController?.pushViewController(controller, animated: true)
//        }
//        else if let anno = view.annotation as? JZCompanyMapAnnotation {
//            let controller = JZMyBossTableViewController()
//            
//            navigationController?.pushViewController(controller, animated: true)
//        }
    }
    
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        if let anno = view.annotation as? JZPersonMapAnnotation {
            let controller = JZJobSeekerViewController()
            controller.userId = anno.uid
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        }
        else if let anno = view.annotation as? JZCompanyMapAnnotation {
            let controller = JZBossInfoViewController()
            controller.userId = anno.uid
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    func selectMap() {
//        let msg = JZMessage(user: JZUserManager.sharedManager.currentUser!, text: "teststss", date: NSDate(), type: .Text, group: nil)
//        let msg = JZSockMessage()
//        msg.uid = 2
//        msg.text = "hhahhahahaha"
//        msg.type = .Message
//        JZSocketManager.sharedManager.sendMessage(msg)
//        let viewController = UINavigationController(rootViewController:JZSelectLocationViewController())
//        viewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
//        self.presentViewController(viewController, animated: true, completion: nil)
//    }

        for i in 0...1 {
            let view = UIImageView()
            view.sd_setImageWithURL(JZUserManager.sharedManager.currentUser!.avatarUrl)
            self.view.addSubview(view)
        }
    }
}
