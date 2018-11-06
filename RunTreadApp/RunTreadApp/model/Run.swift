//
//  Run.swift
//  RunTreadApp
//
//  Created by Apple on 06/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import RealmSwift

class Run : Object {
    
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var pace = 0
    @objc dynamic public private(set) var distance = 0.0
    @objc dynamic public private(set) var duration = 0
    @objc dynamic public private(set) var date = NSDate()
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["pace", "date" , "duration"]
    }
    
    convenience init(pace: Int , distance:  Double , duration: Int){
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        self.date = NSDate()
    }
    
}

