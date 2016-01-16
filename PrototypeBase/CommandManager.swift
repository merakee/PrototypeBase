//
//  ApiAiManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/18/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit

protocol CommandManagerDelegate {
    func updateDebugMode(state:Bool)
    func resetAnnotations()
}

class CommandManager: NSObject {
    var delegate:CommandManagerDelegate?
    
    // MARK: - singleton
    static let sharedManager = CommandManager()
    
    private override init() {
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
    }
    
    // MARK: Response parsing and processing methods
    
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
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        if let responseDict = response as? NSDictionary {
            print(response)
            
            if let result = responseDict["result"] as? NSDictionary{
                if let action  = result["action"] as? String {
                    print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
                    print("Action: " + action)
                    self.executeAction(action, result: result,response: response)
                }
            }
        }
    }
    
    func executeAction(action:String, result: NSDictionary, response:AnyObject){
        switch action{
            //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        case "ActionGreetings":
            self.processGreetings(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
        case "ActionDebugCommand":
            self.processDebugCommands(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
        case "ExecuteCommand":
            self.processCommands(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
        case "ActionEntertainment":
            self.processEntertainment(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
        case "ActionPOIDirection":
            self.processPOIDirection(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
        case "ActionPOISearch":
            self.processPOISearch(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
        case "maps.places":
            self.processPOISearchForMapPlaces(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
        default:
            self.processNotUnderstoodSpeech()
            ContextManager.sharedManager.addErrorToContext()
            print("default...")
        }
    }
    
    func sayResponse(result:NSDictionary){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        if let speech = result["speech"] as? String{
            print("Speech Response: " + speech)
            DialogueManager.sharedManager.speechManager.sayText(speech)
        }
    }
    
    func getParameter(parameterName: String, fromResult result:NSDictionary) -> String {
        if let parameters = result["parameters"] as? NSDictionary{
            if let parameter = parameters[parameterName] as? String {
                return parameter
            }
        }
        
        return ""
    }
    
    // MARK: Command processing
    func processDebugCommands(result:NSDictionary, response:AnyObject){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        let parameter = self.getParameter("debugCommand", fromResult: result)
        switch parameter {
        case "Debug on", "Debug On":
            print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
            self.delegate?.updateDebugMode(true)
            self.sayResponse(result)
        case "Debug off", "Debug Off":
            self.delegate?.updateDebugMode(false)
            self.sayResponse(result)
        default:
            break
        }
    }
    
    func processEntertainment(result:NSDictionary, response:AnyObject){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        let parameter = self.getParameter("content", fromResult: result)
        switch parameter {
        case "story":
            self.sayResponse(result)
            DialogueManager.sharedManager.playContentOfType(.Story)
        case "poem":
            self.sayResponse(result)
            DialogueManager.sharedManager.playContentOfType(.Poem)
        case "joke":
            self.sayResponse(result)
            DialogueManager.sharedManager.playContentOfType(.Joke)
        case "song":
            self.sayResponse(result)
            DialogueManager.sharedManager.playContentOfType(.Song)
        case "news":
            self.sayResponse(result)
            DialogueManager.sharedManager.playContentOfType(.News)
        default:
            break
        }
    }
    
    
    func processNotUnderstoodSpeech(){
        if ContextManager.sharedManager.errorCount < 2 {
            DialogueManager.sharedManager.promptUser(.ErrorPromptFirst)
        }
        else {
            DialogueManager.sharedManager.promptUser(.ErrorPromptSecond)
        }
    }
    func processGreetings(result:NSDictionary, response:AnyObject){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        //let parameter = self.getParameter("command", fromResult: result)
        //print("Command with parameter: " + parameter)
        // self.sayResponse(result)
        DialogueManager.sharedManager.promptUser(.POISearchPrompt)
    }
    
    func processCommands(result:NSDictionary, response:AnyObject){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        let parameter = self.getParameter("command", fromResult: result)
        print("Command with parameter: " + parameter)
        switch parameter{
        case "Pausing":
            DialogueManager.sharedManager.speechManager.pauseSpeech()
        case "Continuing":
            DialogueManager.sharedManager.speechManager.continueSpeech()
        case "Stoping":
            DialogueManager.sharedManager.speechManager.stopSpeech()
        case "Starting Over":
            DialogueManager.sharedManager.speechManager.sayText(ContentManager.sharedManager.currentContent)
        default:
            break
        }
    }
    
    
    func processPOISearch(result:NSDictionary, response:AnyObject){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        let parameter = self.getParameter("poi", fromResult: result)
        MKMapViewManager.sharedManager.findPOI(parameter, near: MapViewManager.sharedManager.currentLocation())
        print("POI search with parameter: " + parameter)
        self.sayResponse(result)
        self.delegate?.resetAnnotations()
    }
    
    func processPOISearchForMapPlaces(result:NSDictionary, response:AnyObject){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        var parameter = self.getParameter("venue_type", fromResult: result)
        if parameter.isEmpty {
            parameter = self.getParameter("venue_chain", fromResult: result)
        }
        
        if !parameter.isEmpty{
            MKMapViewManager.sharedManager.findPOI(parameter, near: MapViewManager.sharedManager.currentLocation())
            print("POI search for Map Places with parameter: " + parameter)
            DialogueManager.sharedManager.promptUser(.POIResponsePrompt,text: parameter)
            self.delegate?.resetAnnotations()
        }
    }
    
    func processPOIDirection(result:NSDictionary, response:AnyObject){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        let parameter = self.getParameter("selection", fromResult: result)
        print("POI direction with parameter: " + parameter)
    }
}


