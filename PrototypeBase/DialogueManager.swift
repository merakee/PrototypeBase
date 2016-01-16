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
    
    // MARK: Play content
    func playContentOfType(type:ContentManager.ContentType){
        self.speechManager.addTextToSpeech(ContentManager.sharedManager.getContentOfType(type))
    }
    // MARK: Prompt dialogue
    func promptUser(type: PromptManager.PromptType, text: String = ""){
        switch type {
        case .InitialPrompt:
            self.speechManager.sayText(PromptManager.sharedManager.initialPrompt())
        case .ErrorPromptFirst:
            self.speechManager.sayText(PromptManager.sharedManager.errorPromptFirst())
        case .ErrorPromptSecond:
            self.speechManager.sayText(PromptManager.sharedManager.errorPromptSecond())
        case .POISearchPrompt:
            self.speechManager.sayText(PromptManager.sharedManager.poiSearchPrompt())
        case .POIResponsePrompt:
            self.speechManager.sayText(PromptManager.sharedManager.poiResponsePrompt(text))
        }
    }
    
}
