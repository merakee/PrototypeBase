//
//  ApiAiManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/18/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
//import SwiftyJSON

class PromptManager: NSObject {
    enum PromptType{
        case InitialPrompt, ErrorPromptFirst, ErrorPromptSecond, POISearchPrompt
    }
    
    static let stringToken = "DFSDsdfhfsd"
    
    let initialPromptArray = ["Hello, where you would like to go?",
        "Hi, where would you like to go today?",
        "Hello, what location would you like me to find for you?",
        "Hello, what place you looking for?"]
    
    let errorPromptArrayFirst = ["Sorry, I did not understand that. Could you please repeat",
        "Sorry, I did not get that. Would you please repeat",
        "Ops, I did not understand that. Do you mind repating?"]
    
    let errorPromptArraySecond = ["I still did not get it. I can only help you to find a place. I am not smart enough to do other task",
        "I still did not understand. I can only help you find a place and not much more. Sorry"]
    
    let poiSearchPromptArray = ["Got it. Looking for " + stringToken,
        "Sure thing. Looking for " + stringToken ,
        "I am on it. Looking for " + stringToken]
    
    // MARK: - singleton
    static let sharedManager = PromptManager()
    
    private override init() {
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
    }
    
    func initialPrompt() -> String {
        return self.initialPromptArray[CommonUtils.sharedInstance.pickRandom(self.initialPromptArray.count)]
    }
    
    func errorPromptFirst() -> String {
        return self.errorPromptArrayFirst[CommonUtils.sharedInstance.pickRandom(self.errorPromptArrayFirst.count)]
    }
    
    func errorPromptSecond() -> String {
        return self.errorPromptArraySecond[CommonUtils.sharedInstance.pickRandom(self.errorPromptArraySecond.count)]
    }
    
    func poiSearchPrompt(poi: String) -> String {
        return self.poiSearchPromptArray[CommonUtils.sharedInstance.pickRandom(self.poiSearchPromptArray.count)].stringByReplacingOccurrencesOfString(PromptManager.stringToken,withString: poi)
    }
}
