//
//  ApiAiManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/18/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit

class ErrorManager: NSObject {
    
    // MARK: - singleton
    static let sharedManager = ErrorManager()
    
    private override init() {
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
    }
    
    func processError(error: NSError){
       print(error)
    }
}
