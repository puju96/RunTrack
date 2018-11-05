//
//  FirstViewController.swift
//  RunTreadApp
//
//  Created by Apple on 02/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import MapKit
class BeginVC: LocationVC{

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
       checkUserAuthLocation()
        mapView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
    }
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }

    @IBAction func centerLocationBtnTapped(_ sender: Any) {
    }
    
    
}

extension BeginVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            checkUserAuthLocation()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
    
}

