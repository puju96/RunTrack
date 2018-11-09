//
//  realmConfig.swift
//  RunTreadApp
//
//  Created by Apple on 07/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfig {
    
    static var runDataConfig : Realm.Configuration {
        let realmPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(REALM_RUN_CONFIG)
        let config = Realm.Configuration(
            fileURL : realmPath,
            schemaVersion: 0,
            migrationBlock :{migration , oldSchemaVersion in
                if (oldSchemaVersion < 0){
                    // nothing to do
                }
                
            })
        return config
    }
}
