//
//  MapViewManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/23/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit

class MapViewManager: NSObject {

    // locations 
    struct FixedLocations {
        static let BaiduOffice = CLLocationCoordinate2DMake(37.409302, -122.023883)
    }
    
    
    // MARK: - singleton
    static let sharedManager = MapViewManager()
    var scoutMapManager: ScoutMapManager!
    
    private override init() {
        scoutMapManager = ScoutMapManager.sharedManager
        super.init()
    }
    
    func initializeMapRegion(mapView: SKMapView, withLocation location:CLLocationCoordinate2D, zoomLevel:Float) {
        //set the map region
        let region = SKCoordinateRegion(center: location, zoomLevel: zoomLevel)
        mapView.visibleRegion = region
    }
}
