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

class ApiAiManager: NSObject {
    
    // MARK: - singleton
    static let sharedManager = ApiAiManager()
    let apiai: ApiAI!
    var voiceRequestButton:AIVoiceRequestButton! = nil
    var voiceRequestButtonDual:AIVoiceRequestButton! = nil
    
    
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
    
    func selectButton(button: AIVoiceRequestButton)-> AIVoiceRequestButton{
        if button === self.voiceRequestButtonDual{
            return self.voiceRequestButton
        }
        return self.voiceRequestButtonDual
    }
    
    func endSession(){
        
    }
    // MARK: AIVoiceRequestButton call back methods
    func processResultOfVoiceButton(button: AIVoiceRequestButton, response: AnyObject) {
        self.listenForCommand(self.selectButton(button))
        CommandManager.sharedManager.processResponse(response)
    }
    
    func processErrorOfVoiceButton(button: AIVoiceRequestButton, error: NSError){
        self.listenForCommand(self.selectButton(button))
        ErrorManager.sharedManager.processError(error)
    }
    
    func listenForCommand(button: AIVoiceRequestButton){
        //CommonUtils.delay(1){
            button.clicked(nil)
        //}
    }
    
}
