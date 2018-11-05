//
//  currentRunVC.swift
//  RunTreadApp
//
//  Created by Apple on 05/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class currentRunVC: UIViewController {

    @IBOutlet weak var swipeBG: UIImageView!
    @IBOutlet weak var slideBtn: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender :)))
        slideBtn.addGestureRecognizer(swipeGesture)
        slideBtn.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
        
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
