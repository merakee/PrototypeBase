//
//  ApiAiManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/18/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit

class ContextInfo: NSObject{
    var response: AnyObject?
    private(set) var  timeStamp: NSDate
    
    private override init() {
        self.timeStamp = NSDate()
        super.init()
    }
    
    convenience init(response: AnyObject) {
        self.init()
        self.response = response
    }
}

class ContextManager: NSObject {
    
    enum ContextType:String{
        case ContextNone, ContextEntertainment, ContextPOISearch
    }
    
    private var contextArray = [ContextInfo]()
    private var currentContextIndex  = 0
    var currentContext: ContextType = .ContextNone
    var errorCount = 0
    
    // MARK: - singleton
    static let sharedManager = ContextManager()
    
    private override init() {
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
    }
    
    
    // MARK: context management methods
    func addResponseToContext(response: AnyObject){
        self.contextArray.insert(ContextInfo(response: response), atIndex: 0)
        self.currentContextIndex = 0
        self.errorCount = 0
    }
    func removeResponseFromContext(){
        if !self.contextArray.isEmpty {
            self.contextArray.removeAtIndex(0)
        }
    }
    
    func addErrorToContext(){
        self.errorCount += 1 
    }
    
    func resetContext(){
        self.contextArray.removeAll()
        self.currentContextIndex = 0
    }
    
}
