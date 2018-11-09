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
    public private(set) var Locations = List<Location>()
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["pace", "date" , "duration"]
    }
    
    convenience init(pace: Int , distance:  Double , duration: Int , Locations: List<Location>){
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        self.date = NSDate()
        self.Locations = Locations
    }
    
    static func addDataToRealm(pace: Int , distance: Double , duration: Int, Locations: List<Location>){
        REALM_QUEUE.sync {
            let run = Run(pace: pace, distance: distance, duration: duration, Locations : Locations)
            do{
                let realm = try Realm(configuration: RealmConfig.runDataConfig)
                try realm.write {
                    realm.add(run)
                }
            }catch{
                print("error in adding realm data")
            }
        }
       
    }
    
    static func getAllRun() -> Results<Run>? {
        do{
            let realm =  try Realm(configuration: RealmConfig.runDataConfig)
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)
            return runs
        }catch{
          return nil
        }
    }
    
}

