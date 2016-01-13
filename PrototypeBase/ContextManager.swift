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
    var contextArray = [ContextInfo]()
    var currentContext  = 0
    
    // MARK: - singleton
    static let sharedManager = ContextManager()
    
    private override init() {
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
    }
    
    
    // MARK: context managment methods
    func addResponsToContext(response: AnyObject){
        self.contextArray.insert(ContextInfo(response: response), atIndex: 0)
    }
}
