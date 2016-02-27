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
    
    @IBOutlet weak var mapView: BMKMapView!
    private let mapManager = BMKMapManager()
    
    let locationService = BMKLocationService()
    
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
        
        locationService.delegate = self
        locationService.startUserLocationService()
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
    
    // MARK: map delegate
    func didUpdateUserHeading(userLocation: BMKUserLocation)
    {
    //NSLog(@"heading is %@",userLocation.heading);
    }
    //处理位置坐标更新
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation)
    {
        NSLog("didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        mapView.updateLocationData(userLocation)
        
        let coor = userLocation.location.coordinate
        if JZLocationManager.sharedManager.coor == nil{
            mapView.setCenterCoordinate(coor, animated:true)
            let point = BMKMapPointForCoordinate(coor)
            let range = 10000.0
            let rect = BMKMapRect(origin: BMKMapPointMake(point.x - range/2, point.y - range/2), size: BMKMapSize(width: range, height: range))
            mapView.setVisibleMapRect(rect, animated:true)
        }
        
        if JZLocationManager.sharedManager.updateCoordinate(coor) {
            if JZUserManager.sharedManager.isLogin {
                JZSearchViewModel.mapSearch("all", coor:coor, range: 1, success:{ (annotations) -> Void in
                    self.mapView.addAnnotations(annotations)
                    }, failure: {
                        JZAlertView.show($0)
                })
            }
        }
        
    }
    
}
