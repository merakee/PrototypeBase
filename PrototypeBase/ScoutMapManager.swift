//
//  ScoutMapManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/22/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit

class ScoutMapManager: NSObject {
    
    // MARK: - singleton
    static let sharedManager = ScoutMapManager()
    var mapsService:SKMapsService!
    
    private override init() {
        let apiKey = "c7c60370a8b42a85e7a3caced43ab86f29ce02385c6d255908fe47f3ea6d0def"
        SKMapsService.sharedInstance().initializeSKMapsWithAPIKey(apiKey, settings:nil)
        mapsService = SKMapsService.sharedInstance()
        super.init()
    }
}