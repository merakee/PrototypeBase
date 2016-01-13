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

class CommandManager: NSObject {
    
    // MARK: - singleton
    static let sharedManager = CommandManager()
    
    private override init() {
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
    }
    
    // MARK: Response parsinga and processing methods
    
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
    
    func processResponse(response: AnyObject){
        if let dict = response as? NSDictionary{
            print(dict)
            if let dict1 = dict["result"] as? NSDictionary{
                print("Resolved Query: " + (dict1["resolvedQuery"] as! String))
                //self.speechManager.sayText(dict1["resolvedQuery"] as? String)
                self.processCommand(dict1["action"] as? String, text: dict1["speech"] as? String)
            }
        }
    }
    
    func processCommand(action: String?, text:String?){
        if let actions = action {
            print("Action: " + actions)
            if self.isActionValid(actions) {
                if let texts = text {
                    print("Speech Response: " + texts)
                    DialogueManager.sharedManager.sayText(text)
                }
            }
            else {
                
            }
        }
        
        
    }
    
    func isActionValid(action: String) -> Bool{
        return action.rangeOfString(".") == nil
    }
}
