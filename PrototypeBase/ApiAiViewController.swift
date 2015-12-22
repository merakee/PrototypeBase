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
    let speechManager = SpeechManager.sharedManager
    
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
        self.setVoiceRequestButton()
        self.layoutView()
    }
    
    func setVoiceRequestButton(){
        voiceRequestButton = AIVoiceRequestButton()
        //voiceRequestButton.color = UIColor.appGreenColor
        //voiceRequestButton.iconColor = UIColor.redColor()
        voiceRequestButton.successCallback = {(AnyObject response) -> Void in
            self.processResult(response)
        }
        voiceRequestButton.failureCallback = {(NSError error) -> Void in
            self.processError(error)
        }
        self.view.addSubview(voiceRequestButton)
    }
    
    func layoutView(){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        //voiceRequestButton.autoSetDimension(.Height, toSize: 72.0)
        //voiceRequestButton.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Width, ofView:voiceRequestButton)
        voiceRequestButton.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        //voiceRequestButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        //voiceRequestButton.autoSetDimension(.Width, toSize: 72.0)
        //voiceRequestButton.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0,30.0,60.0,30.0), excludingEdge: .Top)
        voiceRequestButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60.0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.listenForVoice()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Button Actions
    //    func buttonPressed(sender: UIButton!){
    //        // print(CommonUtils.sharedInstance.getDocumentRootDirectory())
    //        //print(CommonUtils.sharedInstance.getResourceRootDirectory())
    //        // play sound
    //        //AppAudioManager.sharedManager.playSoundFromFile("railroad_crossing_bell", ofType: "wav")
    //        //let aplayer = AppAudioManager.sharedManager.playSoundFromFile("pay", ofType: "mp3")
    //        let aplayer = AppAudioManager.sharedManager.playSoundFromFile("railroad_crossing_bell", ofType: "wav")
    //        aplayer!.play()
    //    }
    
    // MARK: AIVoiceRequestButton call back methods
    func processResult(response: AnyObject) {
        if let dict = response as? NSDictionary{
            print(dict)
            if let dict1 = dict["result"] as? NSDictionary{
                print(dict1["resolvedQuery"])
                //self.speechManager.sayText(dict1["resolvedQuery"] as? String)
                self.speechManager.sayText(dict1["speech"] as? String)
            }
        }
        
        self.listenForVoice()
    }
    
    func processError(error: NSError){
        print(error)
        self.listenForVoice()
    }
    
    func listenForVoice(){
        CommonUtils.delay(1){
            self.voiceRequestButton.clicked(nil)
        }
    }
    
}
