//
//  MapViewManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/23/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import MapKit

protocol MKMapViewManagerDelegate: class {
    //func updatePOIList(pois:[MKMapItem])
    func showCurrentDestination()
}


class MKMapViewManager: NSObject, MKMapViewDelegate {
    // locations
    struct FixedLocations {
        static let BaiduOffice = CLLocationCoordinate2DMake(37.409302, -122.023883)
    }
    
    struct DestinationInfo {
        var mapItem: MKMapItem
        var destinationInfo: MKETAResponse?
    }
    enum MapAnnotationType: String {
        case Current,Primary,Secondary, Selected
    }
    
    enum DestinationInfoType: String{
        case Distance, ETA
    }
    
    weak var delegate:MKMapViewManagerDelegate?
    var currentDestinations = [DestinationInfo]()
    var currentDestinationIndex = 0
    var currentPOI = ""
    
    
    // MARK: - singleton
    static let sharedManager = MKMapViewManager()
    
    private override init() {
        //scoutMapManager = ScoutMapManager.sharedManager
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
        //SKSearchService.sharedInstance().searchServiceDelegate = self
        //SKMapsService.sharedInstance().connectivityMode = SKConnectivityMode.Online
    }
    
    func setMapView(mapView:MKMapView) {
        let region = MKCoordinateRegionMakeWithDistance(
            MKMapViewManager.FixedLocations.BaiduOffice, 2000, 2000)
        mapView.setRegion(region, animated: true)
        mapView.setRegion(region, animated:true)
        self.addAnnotation(mapView, location: self.currentLocation(), type: .Current)
    }
    
    // MARK: location mathods
    func currentLocation() -> CLLocationCoordinate2D {
        return MapViewManager.FixedLocations.BaiduOffice
    }
    
    // MARK: Display related methods
    func addAnnotation(mapView:MKMapView, location: CLLocationCoordinate2D, type: MapAnnotationType) {
        mapView.delegate = self
        let pinAnnotation = MKPointAnnotation()
        pinAnnotation.coordinate = location
        pinAnnotation.subtitle = type.rawValue
        mapView.addAnnotation(pinAnnotation)
    }
    
    func removeAnnotation(mapView: SKMapView, annotationID:Int32){
        mapView.removeAnnotationWithID(annotationID)
    }
    
    func addAnnotationForCurrentDestination(mapView:MKMapView){
        if self.currentDestinations.count > self.currentDestinationIndex{
            self.resetAnnotations(mapView)
            print("Current Index: \(self.currentDestinationIndex)")
            let mapItem  = self.currentDestinations[self.currentDestinationIndex].mapItem
            self.addAnnotation(mapView, location: mapItem.placemark.coordinate, type: .Primary)
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }
    
    //    func addAnnotations(mapView:MKMapView, mapItems: [MKMapItem]){
    //        for (index,item) in mapItems.enumerate() {
    //            if index < 3 {
    //                self.addAnnotation(mapView, location: item.placemark.coordinate, type: ( index == 0 ? .Primary : .Secondary))
    //            }
    //        }
    //
    //        mapView.showAnnotations(mapView.annotations, animated: true)
    //    }
    
    func resetAnnotations(mapView: MKMapView){
        for annotation in mapView.annotations{
            mapView.removeAnnotation(annotation)
        }
        
        self.addAnnotation(mapView, location: self.currentLocation(), type: .Current)
    }
    
    // MARK: POI search methods
    func findPOI(poi:String, near location:CLLocationCoordinate2D){
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = poi
        request.region = MKCoordinateRegionMakeWithDistance(location, 20000, 2000)
        
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler({ [unowned self] (response, error) in
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            }
            else if let results  = response {
                print("Search results retrieved: \(results.mapItems) ")
                self.currentPOI = poi
                self.resetDestinationInfo(results.mapItems)
                self.delegate?.showCurrentDestination()
                CommandManager.sharedManager.processDestinationInfo(poi: poi)
            }
        })
    }
    
    func resetDestinationInfo(mapItems:[MKMapItem]){
        self.currentDestinations.removeAll()
        self.currentDestinationIndex = 0
        for mapitem in mapItems {
            self.currentDestinations.append(DestinationInfo(mapItem: mapitem, destinationInfo: nil))
        }
    }
    
    // MARK: MKDirection info methods
    func getMapItemForLocation(location:CLLocationCoordinate2D,addressDictionary: [String : AnyObject]?) -> MKMapItem {
        return MKMapItem(placemark: MKPlacemark(coordinate: location, addressDictionary:addressDictionary))
    }
    
    func findDirectionETAInfoForCurrentDestination(type:DestinationInfoType){
        self.findDirectionETAInfo(self.getMapItemForLocation(self.currentLocation(), addressDictionary: nil), end: self.currentDestinations[self.currentDestinationIndex].mapItem,type:type)
    }
    
    func findDirectionETAInfo(start:MKMapItem, end:MKMapItem, transportType: MKDirectionsTransportType = .Automobile, type:DestinationInfoType){
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        
        let request = MKDirectionsRequest()
        request.source = start
        request.destination = end
        request.transportType = transportType
        
        let direction = MKDirections(request: request)
        
        direction.calculateETAWithCompletionHandler({ [unowned self] (response, error) in
            if error != nil {
                self.processETACalculationError(error!)
            }
            else if let results  = response {
                self.processETAInformation(results,type:type)
            }
        })
    }
    
    func getCurrentDestinationETA() -> String? {
        if self.currentDestinations.count > self.currentDestinationIndex {
            let cdes = self.currentDestinations[self.currentDestinationIndex]
            if let eta = cdes.destinationInfo?.expectedTravelTime {
                var mins  = ""
                if eta < 60 {
                    mins = "less than one"
                }
                else{
                    mins = String(Int(eta/60.0))
                }
                return "\(mins)"
            }
        }
        
        return nil
    }
    
    func getCurrentDestinationDistance() -> String? {
        if self.currentDestinations.count > self.currentDestinationIndex {
            let cdes = self.currentDestinations[self.currentDestinationIndex]
            if let eta = cdes.destinationInfo?.distance {
                var miles   = ""
                if eta < 1609.34 {
                    miles = "less than one"
                }
                else{
                    miles = String(Int(eta/1609.34))
                }
                return "\(miles)"
            }
        }
        
        return nil
    }
    
    
    func processETACalculationError(error:NSError){
        print("Error occured in ETA calculation: \(error.localizedDescription)")
        
    }
    
    func processETAInformation(response:MKETAResponse,type:DestinationInfoType){
        print("ETA information: \(response) ")
        self.currentDestinations[self.currentDestinationIndex].destinationInfo = response
        if type == .Distance{
            CommandManager.sharedManager.processDestinationDistance()
        }
        else{
            CommandManager.sharedManager.processDestinationETA()
        }
    }
    
    // MARK: MKMapViewDelegate methods
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = "mkmapannotation"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if anView == nil {
            anView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        
        switch annotation.subtitle{
        case .Some(.Some("Current")):
            anView!.pinTintColor = UIColor.blueColor()
        case .Some(.Some("Primary")):
            anView!.pinTintColor = MKPinAnnotationView.redPinColor()
        case .Some(.Some("Secondary")):
            anView!.pinTintColor = MKPinAnnotationView.purplePinColor()
        case .Some(.Some("Selected")):
            anView!.pinTintColor = MKPinAnnotationView.greenPinColor()
        default:
            anView!.pinTintColor = UIColor.blueColor()
        }
        
        return anView
    }
    
}
