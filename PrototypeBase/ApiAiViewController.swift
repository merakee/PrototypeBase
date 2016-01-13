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

class ApiAiViewController: UIViewController {
    let apiAiManager = ApiAiManager.sharedManager
    var voiceRequestButton:AIVoiceRequestButton! = nil
    var voiceRequestButtonDual:AIVoiceRequestButton! = nil
    var mapView: SKMapView!
    
    // MARK: - View Set up
    override func loadView() {
        super.loadView()
        setView()
    }
    
    func setView(){
        // hide or show nav bar
        self.navigationController?.navigationBar.hidden = true
        
        // back ground color
        self.view.backgroundColor = UIColor.appLightBlueColor
        self.setMapView()
        self.setVoiceRequestButton()
        self.layoutView()
    }
    
    func setVoiceRequestButton(){
        voiceRequestButton = AIVoiceRequestButton()
        //voiceRequestButton.color = UIColor.appGreenColor
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
        //voiceRequestButtonDual.color = UIColor.appGreenColor
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
        mapView = SKMapView()//(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)))
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        //show the compass
        mapView.settings.showCompass = true
        //hide the map scale
        mapView.mapScaleView.hidden = false
        mapView.settings.rotationEnabled = false;
        mapView.settings.followUserPosition = true;
        mapView.settings.headingMode = SKHeadingMode.RotatingMap
        // set initial region
        MapViewManager.sharedManager.initializeMapRegion(mapView, withLocation:MapViewManager.FixedLocations.BaiduOffice, zoomLevel: 14)
    }
    func layoutView(){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        //voiceRequestButton.autoSetDimension(.Height, toSize: 72.0)
        //voiceRequestButton.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Width, ofView:voiceRequestButton)
        //voiceRequestButton.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        //voiceRequestButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        //voiceRequestButton.autoSetDimension(.Width, toSize: 72.0)
        //voiceRequestButton.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0,30.0,60.0,30.0), excludingEdge: .Top)
        voiceRequestButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 20)
        voiceRequestButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 20.0)
        
        
        //voiceRequestButtonDual.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
