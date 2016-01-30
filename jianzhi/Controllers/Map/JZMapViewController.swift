//
//  JZMapViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMapViewController: UIViewController, BMKGeneralDelegate, BMKMapViewDelegate {

    let annotionIdentifier = "annotaion"
    
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
        let annotation = JZMapAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(39.915, 116.404)
        annotation.title = "title"
        annotation.subtitle = "subtitle"
        mapView.addAnnotation(annotation)
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
        var annotionView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotionIdentifier)
        if annotionView == nil {
            annotionView = JZMapUserAnnotationView(annotation: annotation, reuseIdentifier: annotionIdentifier)
            
//            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 50))
//            annotionView.paopaoView = BMKActionPaopaoView(customView: customView)
//            customView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.3)
            
            let left = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
            left.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3)
            annotionView.leftCalloutAccessoryView = left
            
        }
        annotionView.image = UIImage(named: "anno")
        
        
        return annotionView
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        
    }
    
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        
    }
    
    func selectMap() {
        JZSocketManager.sharedManager.sendMessage("hehehehehe")
//        let viewController = UINavigationController(rootViewController:JZSelectLocationViewController())
//        viewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
//        self.presentViewController(viewController, animated: true, completion: nil)
    }

}
