//
//  FirstViewController.swift
//  RunTreadApp
//
//  Created by Apple on 02/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift
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
        
        print("run value \(Run.getAllRun())")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        mapView.delegate = self
        manager?.startUpdatingLocation()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpMapView()
    }
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func setUpMapView(){
        if let overlay = addLastRun(){
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.addOverlay(overlay)
            lastViewBg.isHidden = false
            lastClosedBtn.isHidden = false
            lastViewStackView.isHidden = false
        }else{
            mapView.userTrackingMode = .follow
            lastViewBg.isHidden = true
            lastClosedBtn.isHidden = true
            lastViewStackView.isHidden = true
        }
        
    }
    
    func addLastRun() -> MKPolyline? {
        guard let lastRun = Run.getAllRun()?.first else {return nil}
        pace.text = lastRun.pace.formatDurationString()
        distance.text = "\(lastRun.distance.meterTomiles(places: 2)) mi"
        duration.text = lastRun.duration.formatDurationString()
        var coordinate = [CLLocationCoordinate2D]()
        for location in lastRun.Locations {
            coordinate.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        
        mapView.userTrackingMode = .none
        mapView.setRegion(centerOnMapLastrunLocation(locations: lastRun.Locations), animated: true)
        
        return MKPolyline(coordinates: coordinate, count: lastRun.Locations.count)
    }
    
    func centerOnUserLocation(){
        mapView.userTrackingMode = .follow
        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    func centerOnMapLastrunLocation(locations : List<Location>)  -> MKCoordinateRegion {
        guard let initialLoc = locations.first else { return MKCoordinateRegion()}
        var minlat = initialLoc.latitude
        var minlng = initialLoc.longitude
        var maxlat = minlat
        var maxlng = minlng
        
        for location in locations {
            minlat = min(minlat,location.latitude)
            minlng = min(minlng,location.longitude)
            maxlat = max(maxlat,location.latitude)
            maxlng = max(maxlng,location.longitude)
        }
        
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minlat + maxlat)/2, longitude: (minlng + maxlng)/2), span: MKCoordinateSpan(latitudeDelta: (maxlat - minlat)*1.5, longitudeDelta: (maxlng - minlng)*1.5))
    }

    @IBAction func lastClosedBtnTapped(_ sender: Any) {
        lastViewBg.isHidden = true
        lastClosedBtn.isHidden = true
        lastViewStackView.isHidden = true
    }
    @IBAction func centerLocationBtnTapped(_ sender: Any) {
        centerOnUserLocation()
    }
    
    
}

extension BeginVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            checkUserAuthLocation()
            mapView.showsUserLocation = true
            
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        renderer.lineWidth = 5
        return renderer
    }
    
}

