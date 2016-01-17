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
        case InitialPrompt,
        ErrorPromptFirst,
        ErrorPromptSecond,
        POISearchPrompt,
        POIResponsePrompt,
        POIDestinationETAInfo,
        POIDestinationETASearch,
        POIDestinationDistanceInfo,
        POIDestinationDistanceSearch
    }
    
    static let stringToken = "DFSDsdfhfsd"
    
    let salutationArray = ["Hi","Hey,","Hello,"]
    let introductionArray = ["I'm Iris.", "I am Iris.", "This is Iris.","Iris here."]
    let poiPromptArray = ["Where you would like to go?",
        "Where would you like to go today?",
        "What location would you like me to find for you?",
        "What place you looking for?",
        "What place do you want me to find for you",
        "what place do you want me to find",
        "What location you wish me to find"]
    
    let poiResponsePromptArray = ["Got it. Looking for " + stringToken,
        "Sure thing. Looking for " + stringToken ,
        "I am on it. Looking for " + stringToken]
    
    let errorPromptArrayFirst = ["Sorry, I did not understand that. Could you please repeat",
        "Sorry, I did not get that. Would you please repeat",
        "Oops, I did not understand that. Do you mind repeating?",
        "My apology, I did not get that. Would you please repeat?"]
    
    let errorPromptArraySecond = ["I still did not get it. I can only help you to find a place. I am not smart enough to do other task",
        "I still did not understand. I can only help you find a place and not much more. Sorry"]
    
    let poiDestinationETASearchPromptArray = ["Looking up Estimated Travel time"]
    let poiDestinationETAInfoPromptArray = ["Estimated Travel time is \(stringToken) minutes"]

    let poiDestinationDistanceSearchPromptArray = ["Looking up destination distance"]
    let poiDestinationDistanceInfoPromptArray = ["It is \(stringToken) miles away"]
    
    
    // MARK: - singleton
    static let sharedManager = PromptManager()
    
    private override init() {
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
    }
    
    func initialPrompt() -> String {
        return self.pickRandomFromArray(self.salutationArray) + " " + self.pickRandomFromArray(self.introductionArray) + " " +
            self.pickRandomFromArray(self.poiPromptArray)
    }
    
    func poiSearchPrompt() -> String {
        return self.pickRandomFromArray(self.salutationArray) + " " + self.pickRandomFromArray(self.poiPromptArray)
    }
    
    func poiResponsePrompt(poi: String) -> String {
        return self.pickRandomFromArray(self.poiResponsePromptArray).stringByReplacingOccurrencesOfString(PromptManager.stringToken,withString: poi)
    }
    
    func poiDestinationDistanceInfoPrompt(text: String) -> String {
        return self.pickRandomFromArray(self.poiDestinationDistanceInfoPromptArray).stringByReplacingOccurrencesOfString(PromptManager.stringToken,withString: text)
    }
    
    func poiDestinationDistanceSearchPrompt(text: String) -> String {
        return self.pickRandomFromArray(self.poiDestinationDistanceSearchPromptArray)
    }
    
    func poiDestinationETAInfoPrompt(text: String) -> String {
        return self.pickRandomFromArray(self.poiDestinationETAInfoPromptArray).stringByReplacingOccurrencesOfString(PromptManager.stringToken,withString: text)
    }
    
    func poiDestinationETASearchPrompt(text: String) -> String {
        return self.pickRandomFromArray(self.poiDestinationETASearchPromptArray)
    }
    
    
    func errorPromptFirst() -> String {
        return self.pickRandomFromArray(self.errorPromptArrayFirst)
    }
    
    func errorPromptSecond() -> String {
        return self.pickRandomFromArray(self.errorPromptArraySecond)
    }
    
    
    
    func pickRandomFromArray(array: [String]) -> String{
        return array[CommonUtils.sharedInstance.pickRandom(array.count)]
    }
}
