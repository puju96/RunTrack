//
//  currentRunVC.swift
//  RunTreadApp
//
//  Created by Apple on 05/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import MapKit
class currentRunVC: LocationVC {

    @IBOutlet weak var swipeBG: UIImageView!
    @IBOutlet weak var slideBtn: UIImageView!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var pauseBtn: UIButton!
    
    var startLocation : CLLocation!
    var lastLocation : CLLocation!
    var runDistance = 0.0
    var timer = Timer()
    var counter = 0
    var pace = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender :)))
        slideBtn.addGestureRecognizer(swipeGesture)
        slideBtn.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      manager?.delegate = self
        manager?.distanceFilter = 3
        startRun()
    }
    func startRun(){
        manager?.startUpdatingLocation()
        startTimer()
    }
    
    func endRun(){
        manager?.stopUpdatingLocation()
    }
    
    func pauseRun(){
        startLocation = nil
        lastLocation = nil
        timer.invalidate()
        manager?.stopUpdatingLocation()
        pauseBtn.setImage(#imageLiteral(resourceName: "resumeButton"), for: .normal)
    }
    
    func startTimer(){
        durationLbl.text = counter.formatDurationString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter(){
        counter += 1
         durationLbl.text = counter.formatDurationString()
    }
    
    func calculatePace(time seconds : Int, miles : Double) -> String{
        pace = Int(Double(seconds) / miles)
        return pace.formatDurationString()
    }
    
    @IBAction func pauseBtnTapped(_ sender: Any) {
        if timer.isValid {
            pauseRun()
        }else {
            startRun()
        }
        
    }
    
    @objc func endRunSwiped(sender :UIPanGestureRecognizer){
        let minPosition :CGFloat = 70
        let maxPosition : CGFloat = 120
        if let sliderView = sender.view{
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed{
                let translation = sender.translation(in: self.view)
                if sliderView.center.x >= (swipeBG.center.x - minPosition) && sliderView.center.x <= (swipeBG.center.x + maxPosition){
                    sliderView.center.x = sliderView.center.x + translation.x
                }
                else if sliderView.center.x >= (swipeBG.center.x + maxPosition){
                    sliderView.center.x = swipeBG.center.x + maxPosition
                    
                    dismiss(animated: true, completion: nil)
                }
                else{
                    sliderView.center.x = swipeBG.center.x - minPosition
                }
                sender.setTranslation(CGPoint.zero, in: self.view)
            }
            else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.1) {
                     sliderView.center.x = self.swipeBG.center.x - minPosition
                }
              
            }
            
            
        }

    }
    
}

extension currentRunVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkUserAuthLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        if startLocation == nil {
            startLocation = locations.first
        }
        else if let location = locations.last{
            runDistance += lastLocation.distance(from: location)
            distanceLbl.text = "\(runDistance.meterTomiles(places: 2))"
            if counter > 0 && runDistance > 0 {
                paceLbl.text = calculatePace(time: counter, miles: runDistance.meterTomiles(places: 2))
            }
            
           
        }
        lastLocation = locations.last
    }
    
}
