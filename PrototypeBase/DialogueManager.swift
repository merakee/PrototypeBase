//
//  ApiAiManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/18/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
//import SwiftyJSON

class DialogueManager: NSObject {
    let speechManager = SpeechManager.sharedManager
    
    // MARK: - singleton
    static let sharedManager = DialogueManager()
    
    private override init() {
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
    }
    
    
    func sayText(text: String?){
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        if let texts = text {
            print(texts)
            self.speechManager.sayText(texts)
        }
    }
    
    func pauseSpeech(){
        
    }
    
    func continueSpeech(){
        
    }
    
    func endSpeech(){
        
    }
    
    // MARK: Prompt dialogue
    
    func promptUser(type: PromptManager.PromptType, text: String = ""){
        switch type {
        case .InitialPrompt:
            sayText(PromptManager.sharedManager.initialPrompt())
        case .ErrorPromptFirst:
            sayText(PromptManager.sharedManager.errorPromptFirst())
        case .ErrorPromptSecond:
            sayText(PromptManager.sharedManager.errorPromptSecond())
        case .POISearchPrompt:
            sayText(PromptManager.sharedManager.poiSearchPrompt(text))
        }
    }
    
}
