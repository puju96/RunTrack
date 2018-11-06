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

    @IBOutlet weak var pace: UILabel!
   
    @IBOutlet weak var lastViewBg: UIView!
    @IBOutlet weak var lastViewStackView: UIStackView!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var lastClosedBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
       checkUserAuthLocation()
        mapView.delegate = self
        print("run value \(Run.getAllRun())")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
        getLastRun()
    }
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func getLastRun() {
        guard let lastRun = Run.getAllRun()?.first else {
            lastViewBg.isHidden = true
            lastClosedBtn.isHidden = true
            lastViewStackView.isHidden = true
            return
        }
        lastViewBg.isHidden = false
        lastClosedBtn.isHidden = false
        lastViewStackView.isHidden = false
        pace.text = lastRun.pace.formatDurationString()
        distance.text = "\(lastRun.distance.meterTomiles(places: 2)) mi"
        duration.text = lastRun.duration.formatDurationString()
    }

    @IBAction func lastClosedBtnTapped(_ sender: Any) {
        lastViewBg.isHidden = true
        lastClosedBtn.isHidden = true
        lastViewStackView.isHidden = true
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

