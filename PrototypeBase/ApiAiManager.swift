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
    
    func parseJSONData(response: AnyObject, inout error: NSError?) -> NSDictionary? {
        
        if let responseData = response.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let results = try NSJSONSerialization.JSONObjectWithData(responseData, options: []) as! [String:AnyObject]
                print(results)
                return results
            } catch let parseError as NSError {
                error = parseError
                print("JSON parser error: \(error!.localizedDescription)")
            }
        } else {
            print("data convertion error: cannot convert to NSData")
        }
        return nil
    }
    
}
