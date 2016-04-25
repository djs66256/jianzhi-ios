//
//  JZMapViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/1.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMapViewController: JZViewController, BMKGeneralDelegate, BMKMapViewDelegate, BMKLocationServiceDelegate {

    let personAnnotationIdentifier = "person"
    let companyAnnotationIdentifier = "company"
    
    var userLocation: BMKUserLocation?
    
    @IBOutlet weak var mapView: BMKMapView!
    private let mapManager = BMKMapManager()
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        mapManager.start(BaiduMap.accessKey, generalDelegate: self)
        
        self.navigationItem.title = "Map"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("userLocationUpdatedNotification:"), name: JZNotification.UserLocationUpdated, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("userLogoutNotification:"), name: JZNotification.Logout, object: nil)
        JZUserManager.sharedManager.userLocationDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view.
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "select", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("selectMap"))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

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
    
    func didUpdateUserHeading(userLocation: BMKUserLocation)
    {
        
    }
    //处理位置坐标更新
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation)
    {
        let coor = userLocation.location.coordinate
        if self.userLocation == nil {
            mapView.updateLocationData(JZUserManager.sharedManager.userLocation)
            mapView.setCenterCoordinate(coor, animated:true)
            let point = BMKMapPointForCoordinate(coor)
            let range = 10000.0
            let rect = BMKMapRect(origin: BMKMapPointMake(point.x - range/2, point.y - range/2), size: BMKMapSize(width: range, height: range))
            mapView.setVisibleMapRect(rect, animated:true)
        }
        self.userLocation = userLocation
    }
    
    func userLocationUpdatedNotification(noti:NSNotification) {
        if let coor = JZUserManager.sharedManager.userLocation?.location.coordinate {
            JZSearchViewModel.mapSearch("all", coor:coor, range: 1, success:{ (annotations) -> Void in
                self.mapView.addAnnotations(annotations)
                }, failure: {
                    JZAlertView.show($0)
            })
        }
    }
    
    func userLogoutNotification(noti: NSNotification) {
        userLocation = nil
    }
    
}
