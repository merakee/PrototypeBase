//
//  ApiAiTextButtonViewController.swift
//  PrototypeBase
//
//  Created by Bijit on 12/18/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import PureLayout
import ApiAI

class ApiAiTextButtonViewController: UIViewController {
    
    let apiAiManager = ApiAiManager.sharedManager
    let speechManager = SpeechManager.sharedManager
    var activity: UIActivityIndicatorView!
    var startListeningButton: UIButton!
    var stopListeningButton: UIButton!
    var useVAD: UISwitch!
    
    var currentVoiceRequest: AIVoiceRequest? = nil
    
    // MARK: - View Set up
    override func loadView() {
        super.loadView()
        setView()
    }
    
    
    func setView(){
        // hide or show nav bar
        self.navigationController?.navigationBar.hidden = true
        
        // back ground color
        self.view.backgroundColor = UIColor.whiteColor()//appBlueColor
        
        // other set up
        startListeningButton = AppUIManager.sharedManager.getButtonWithTitle("Start Listening", buttonColor: UIColor.blueColor(), textColor: UIColor.whiteColor())
        self.view.addSubview(startListeningButton)
        startListeningButton.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0,30.0,200.0,30.0), excludingEdge: .Top)
        startListeningButton.autoSetDimension(.Height, toSize: 40.0)
        startListeningButton.addTarget(self, action: "startListening:", forControlEvents: .TouchUpInside)
        
        
        stopListeningButton = AppUIManager.sharedManager.getButtonWithTitle("Stop Listening", buttonColor: UIColor.blueColor(), textColor: UIColor.whiteColor())
        self.view.addSubview(stopListeningButton)
        stopListeningButton.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Height, ofView:  startListeningButton)
        stopListeningButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 30.0)
        stopListeningButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30.0)
        stopListeningButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: startListeningButton, withOffset: 20)
        stopListeningButton.addTarget(self, action: "stopListening:", forControlEvents: .TouchUpInside)
        
        // button.autoSetDimension(.Height, toSize: 100.0)
        //button.autoSetDimension(.Width, toSize: 100.0)
        //button.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Width, ofView:button)
        //button.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0,30.0,60.0,30.0), excludingEdge: .Top)
        //button.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        //button.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60.0)
        
        //button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changeStateToStop()
    }
    
    func startListening(sender: UIButton) {
        self.changeStateToListening()
        
        let request = apiAiManager.apiai.voiceRequest()
        
        if let vad = self.useVAD {
            request.useVADForAutoCommit = vad.on
        }
        
        request.setCompletionBlockSuccess({[unowned self] (AIRequest request, AnyObject response) -> Void in
            // let resultNavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultNavigationController
            //resultNavigationController.response = response
            //self.presentViewController(resultNavigationController, animated: true, completion: nil)
            print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
            
            if let dict = response as? NSDictionary{
                print(dict)
                if let dict1 = dict["result"] as? NSDictionary{
                    print(dict1["resolvedQuery"])
                    //self.speechManager.sayText(dict1["resolvedQuery"] as? String)
                   self.speechManager.sayText(dict1["speech"] as? String)
                }
            }
            //self.processResponse(response)
            
            self.changeStateToStop()
            
            }, failure: { (AIRequest request, NSError error) -> Void in
                self.changeStateToStop()
        })
        
        self.currentVoiceRequest = request
        
        apiAiManager.apiai.enqueue(request)
    }
    
    func processResponse(response:AnyObject){
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        var error: NSError?
        let result = apiAiManager.parseJSONData(response, error:&error)
        
        print(result)
    }
    
    func stopListening(sender: UIButton) {
        self.currentVoiceRequest?.commitVoice()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.currentVoiceRequest?.cancel()
    }
    
    func changeStateToStop() {
        self.activity?.stopAnimating()
        self.startListeningButton?.enabled = true
        self.stopListeningButton?.enabled = false
        
        self.useVAD?.enabled = true
    }
    
    func changeStateToListening() {
        self.activity?.startAnimating()
        self.startListeningButton?.enabled = false
        self.stopListeningButton?.enabled = true
        
        self.useVAD?.enabled = false
    }
    
}

