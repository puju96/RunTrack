//
//  LocationVC.swift
//  RunTreadApp
//
//  Created by Apple on 05/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import MapKit
class LocationVC: UIViewController , MKMapViewDelegate{
    
    var manager : CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.activityType = .fitness
       
    }
    
    func checkUserAuthLocation(){
        if  CLLocationManager.authorizationStatus() != .authorizedWhenInUse{
            manager?.requestWhenInUseAuthorization()
        }
        
    }
    

   
}
