//
//  MapViewManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/23/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import MapKit

protocol MKMapViewManagerDelegate {
    func updatePOIList(pois:[MKMapItem])
}


class MKMapViewManager: NSObject, MKMapViewDelegate {
    var delegate:MKMapViewManagerDelegate?
    
    // locations
    struct FixedLocations {
        static let BaiduOffice = CLLocationCoordinate2DMake(37.409302, -122.023883)
    }
    
    enum MapAnnotationType: String {
        case Current,Primary,Secondary, Selected
    }
    
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
    
    func addAnnotations(mapView:MKMapView, mapItems: [MKMapItem]){
        for (index,item) in mapItems.enumerate() {
            if index < 3 {
                self.addAnnotation(mapView, location: item.placemark.coordinate, type: ( index == 0 ? .Primary : .Secondary))
            }
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
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
        
        search.startWithCompletionHandler({(response, error) in
            
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            }
            else if let results  = response {
                print("Search results retrieved: \(results.mapItems) ")
                self.delegate?.updatePOIList(results.mapItems)
            }
        })
        
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
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        
        return anView
    }
    
}
