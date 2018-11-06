//
//  extensions.swift
//  RunTreadApp
//
//  Created by Apple on 05/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

extension Double {
    func meterTomiles (places : Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return ((self / 1609.34) * divisor).rounded() / divisor
    }
}

extension Int {
    func formatDurationString () -> String{
        let durationHours = self / 3600
        let durationMinute = (self % 3600) / 60
        let durationSecond = (self % 3600) % 60
        if durationSecond < 0{
            return "00:00:00"
        }else{
            if durationHours == 0{
                return String(format: "%02d:%02d", durationMinute,durationSecond)
            }
            else{
                return String(format: "%02d:%02d:%02d", durationHours,durationMinute,durationSecond)
            }
        }
    }
}

extension NSDate {
    func getDateString() -> String{
        let calender = Calendar.current
        let year = calender.component(.year, from: self as Date)
         let month = calender.component(.month, from: self as Date)
         let day = calender.component(.day, from: self as Date)
        return "\(day)/\(month)/\(year)"
        
    }
}
