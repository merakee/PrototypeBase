//
//  MapViewManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/23/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit

protocol MapViewManagerDelegate: class {
    func updatePOIList(pois:[AnyObject])
}
    
    
class MapViewManager: NSObject, SKSearchServiceDelegate{
    weak var delegate:MapViewManagerDelegate?
    
    // locations
    struct FixedLocations {
        static let BaiduOffice = CLLocationCoordinate2DMake(37.409302, -122.023883)
    }
    
    enum MapAnnotationType{
        case Current,Primary,Secondary, Selected
    }
    
    // MARK: - singleton
    static let sharedManager = MapViewManager()
    var scoutMapManager: ScoutMapManager!
    var annotationID: Int32 = 1
    
    private override init() {
        scoutMapManager = ScoutMapManager.sharedManager
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
        SKSearchService.sharedInstance().searchServiceDelegate = self
        SKMapsService.sharedInstance().connectivityMode = SKConnectivityMode.Online
    }
    
    func initializeMapRegion(mapView: SKMapView, withLocation location:CLLocationCoordinate2D, zoomLevel:Float) {
        //set the map region
        let region = SKCoordinateRegion(center: location, zoomLevel: zoomLevel)
        mapView.visibleRegion = region
        self.addAnnotation(mapView, location: location, type:.Current)
    }
    
    // MARK: location mathods
    func currentLocation() -> CLLocationCoordinate2D {
       return MapViewManager.FixedLocations.BaiduOffice
    }
    
    // MARK: Display related methods
    func addAnnotation(mapView:SKMapView, location: CLLocationCoordinate2D, type: MapAnnotationType) -> Int32 {
        let annotation = SKAnnotation()
        self.annotationID += 1
        annotation.identifier = self.annotationID
        switch type{
        case .Current:
            annotation.annotationType = SKAnnotationType.Blue
        case .Primary:
            annotation.annotationType = SKAnnotationType.Red
        case .Secondary:
            annotation.annotationType = SKAnnotationType.Purple
        case .Selected:
            annotation.annotationType = SKAnnotationType.DestinationFlag
        }
        annotation.location = location
        let animationSettings = SKAnimationSettings()
        mapView.addAnnotation(annotation, withAnimationSettings: animationSettings)
        
        return self.annotationID
    }
    
    func removeAnnotation(mapView: SKMapView, annotationID:Int32){
        mapView.removeAnnotationWithID(annotationID)
    }
    
    func addAnnotations(mapView:SKMapView, pois: [AnyObject]){
        var count  = 0
        for result in pois{
            if let poi = result as? SKSearchResult{
                self.addAnnotation(mapView, location: poi.coordinate, type: ( count==0 ? .Primary : .Secondary))
                count++
            }
        }
        
    }
    
//    func zoomToFitAllAnnotations(mapView:SKMapView){
//        MKMapRect zoomRect = MKMapRectNull
//        for (id <MKAnnotation> annotation in mapView.annotations) {
//            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
//            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
//            if (MKMapRectIsNull(zoomRect)) {
//                zoomRect = pointRect;
//            } else {
//                zoomRect = MKMapRectUnion(zoomRect, pointRect);
//            }
//        }
//        [mapView setVisibleMapRect:zoomRect animated:YES];
//        
//    }
    // MARK: POI search methods
    func findPOI(poi:String, near location:CLLocationCoordinate2D){
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        let searchObject = SKNearbySearchSettings()
        searchObject.coordinate = location
        searchObject.searchTerm = poi
        searchObject.radius = 20000
        searchObject.searchMode = SKSearchMode.Online
        searchObject.searchResultSortType = SKSearchResultSortType.ProximitySort
        //let a = [SKPOICategory.Airport]
       // searchObject.searchCategories = [SKPOICategory.Airport.toRaw(), SKPOICategory.Atm.toRaw(), SKPOICategory.Accessoires.toRaw(), SKPOICategory.Car.toRaw(), SKPOICategory.University.toRaw(), SKPOICategory.Supermarket.toRaw()]
        SKSearchService.sharedInstance().searchResultsNumber = 3
        SKSearchService.sharedInstance().startNearbySearchWithSettings(searchObject)
        
    }
    
    func searchService(searchService: SKSearchService!, didRetrieveNearbySearchResults searchResults: [AnyObject]!, withSearchMode searchMode: SKSearchMode) {
        NSLog("Search results retrieved: %@", searchResults)
        self.delegate?.updatePOIList(searchResults)
        
    }
    
    func searchService(searchService: SKSearchService!, didFailToRetrieveNearbySearchResultsWithSearchMode searchMode: SKSearchMode) {
        NSLog("Search failed")
    }
}
