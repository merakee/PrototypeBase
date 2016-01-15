//
//  ApiAiViewController.swift
//  PrototypeBase
//
//  Created by Bijit on 12/18/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import PureLayout
import ApiAI
import MapKit

class MapViewController: UIViewController, CommandManagerDelegate, ApiAiManagerDelegate, MKMapViewManagerDelegate {
    let apiAiManager = ApiAiManager.sharedManager
    var voiceRequestButton:AIVoiceRequestButton! = nil
    var voiceRequestButtonDual:AIVoiceRequestButton! = nil
    var mapView: MKMapView!
    let commandManager = CommandManager.sharedManager
    var debugMode = true
    
    // MARK: - View Set up
    override func loadView() {
        super.loadView()
        setView()
    }
    
    func setView(){
        // hide or show nav bar
        self.navigationController?.navigationBar.hidden = true
        
        self.commandManager.delegate = self
        self.apiAiManager.delegate = self
        MKMapViewManager.sharedManager.delegate = self
        // back ground color
        self.view.backgroundColor = UIColor.appLightBlueColor
        self.setMapView()
        self.setVoiceRequestButton()
        self.layoutView()
    }
    
    func setVoiceRequestButton(){
        voiceRequestButton = AIVoiceRequestButton()
        voiceRequestButton.color = UIColor.redColor()
        //voiceRequestButton.iconColor = UIColor.redColor()
        voiceRequestButton.successCallback = {(AnyObject response) -> Void in
            self.apiAiManager.processResultOfVoiceButton(self.voiceRequestButton, response: response)
        }
        voiceRequestButton.failureCallback = {(NSError error) -> Void in
            self.apiAiManager.processErrorOfVoiceButton(self.voiceRequestButton, error: error)
        }
        self.view.addSubview(voiceRequestButton)
        voiceRequestButton.hidden = true
        
        voiceRequestButtonDual = AIVoiceRequestButton()
        voiceRequestButtonDual.color = UIColor.redColor()
        //voiceRequestButtonDual.iconColor = UIColor.redColor()
        voiceRequestButtonDual.successCallback = {(AnyObject response) -> Void in
            self.apiAiManager.processResultOfVoiceButton(self.voiceRequestButtonDual, response: response)
        }
        voiceRequestButtonDual.failureCallback = {(NSError error) -> Void in
            self.apiAiManager.processErrorOfVoiceButton(self.voiceRequestButtonDual, error: error)
        }
        self.view.addSubview(voiceRequestButtonDual)
        voiceRequestButtonDual.hidden = true
    }
    
    func setMapView(){
        mapView = MKMapView()
        MKMapViewManager.sharedManager.setMapView(self.mapView)
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    }
    func layoutView(){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        //voiceRequestButton.autoSetDimension(.Height, toSize: 72.0)
        //voiceRequestButton.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Width, ofView:voiceRequestButton)
        voiceRequestButton.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        //voiceRequestButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        //voiceRequestButton.autoSetDimension(.Width, toSize: 72.0)
        //voiceRequestButton.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0,30.0,60.0,30.0), excludingEdge: .Top)
        //voiceRequestButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 20)
        voiceRequestButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 20.0)
        
        
        voiceRequestButtonDual.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        //voiceRequestButtonDual.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        //voiceRequestButtonDual.autoSetDimension(.Width, toSize: 72.0)
        //voiceRequestButtonDual.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0,30.0,60.0,30.0), excludingEdge: .Top)
        voiceRequestButtonDual.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 20)
        voiceRequestButtonDual.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 20.0)
        
        // mapview
        mapView.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: self.view)
        mapView.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 0.0)
        mapView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0.0)
        //mapView.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: voiceRequestButton, withOffset: 10)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.apiAiManager.startSession(self.voiceRequestButton, buttonDaul:self.voiceRequestButtonDual)
        DialogueManager.sharedManager.promptUser(.InitialPrompt)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: command manager delegate methods
    func updateDebugMode(state: Bool) {
        self.debugMode = state
        if !self.debugMode {
            self.voiceRequestButton.hidden = true
            self.voiceRequestButtonDual.hidden = true
        }
    }
    
    // MARK: command manager delegate methods
    func updateVoiceButton(button: AIVoiceRequestButton) {
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        if self.debugMode {
            //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
            if button == self.voiceRequestButton {
                self.voiceRequestButton.hidden = false
                self.voiceRequestButtonDual.hidden = true
            }
            else{
                self.voiceRequestButton.hidden = true
                self.voiceRequestButtonDual.hidden = false
            }
        }
    }
    
    
    // MARK: SKMapViewDelegate methods
    func mapView(mapView: SKMapView!, didChangeToRegion region:SKCoordinateRegion) {
    }
    
    func mapView(mapView: SKMapView!, didTapAtCoordinate coordinate:CLLocationCoordinate2D) {
    }
    
    func mapView(mapView: SKMapView!, didRotateWithAngle angle:Float) {
    }
    
    // MARK: MapViewManagerDelegate
    func updatePOIList(pois: [MKMapItem]) {
        MKMapViewManager.sharedManager.addAnnotations(self.mapView, mapItems: pois)
    }
    
    func resetAnnotations() {
     MKMapViewManager.sharedManager.resetAnnotations(self.mapView)
    }
}
