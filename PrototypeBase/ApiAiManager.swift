//
//  ApiAiManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/18/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import ApiAI
//import SwiftyJSON

protocol ApiAiManagerDelegate: class {
    func updateVoiceButton(button:AIVoiceRequestButton)
}

class ApiAiManager: NSObject {
    
    weak var delegate:ApiAiManagerDelegate?
    
    // MARK: - singleton
    static let sharedManager = ApiAiManager()
    let apiai: ApiAI!
    var voiceRequestButton:AIVoiceRequestButton! = nil
    var voiceRequestButtonDual:AIVoiceRequestButton! = nil
    var voiceRequestButtonCurrent:AIVoiceRequestButton! = nil
    
    private override init() {
        self.apiai = ApiAI.sharedApiAI()
        super.init()
        // start AVAudio Session
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.setActive(true)
        } catch {
            // hadle error
        }
        self.configureApiAi()
    }
    
    
    func configureApiAi() {
        // Api Pi
        let configuration: AIConfiguration = AIDefaultConfiguration()
        
        configuration.clientAccessToken = "ac1332a355bf46dd98fd41b05b5808b9"
        configuration.subscriptionKey = "1b1b3bd0-43da-4f9d-80ac-499a867695ef"
        
        self.apiai.configuration = configuration
    }
    
    // MARK: Session methods
    func startSession(button: AIVoiceRequestButton, buttonDaul: AIVoiceRequestButton){
        self.voiceRequestButton = button
        self.voiceRequestButtonDual = buttonDaul
        self.listenForCommand(self.voiceRequestButton)
    }
    
    func updateButton(button: AIVoiceRequestButton)-> AIVoiceRequestButton{
        if button === self.voiceRequestButtonDual{
            self.voiceRequestButtonCurrent =  self.voiceRequestButton
        }
        else {
            self.voiceRequestButtonCurrent = self.voiceRequestButtonDual
        }
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        self.delegate?.updateVoiceButton(self.voiceRequestButtonCurrent)
        return self.voiceRequestButtonCurrent
    }
    
    func endSession(){
        
    }
    // MARK: AIVoiceRequestButton call back methods
    func processResultOfVoiceButton(button: AIVoiceRequestButton, response: AnyObject) {
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        self.listenForCommand(self.updateButton(button))
        CommandManager.sharedManager.processResponse(response)
    }
    
    func processErrorOfVoiceButton(button: AIVoiceRequestButton, error: NSError){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        self.listenForCommand(self.updateButton(button))
        ErrorManager.sharedManager.processError(error)
    }
    
    func listenForCommand(button: AIVoiceRequestButton){
        //CommonUtils.delay(1){
        button.clicked(nil)
        //}
    }
    
}
