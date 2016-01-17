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
            ContextManager.sharedManager.currentContext = .ContextEntertainment
        case "ActionPOIDirection":
            self.processPOIDirection(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
        case "ActionDestinationETA":
            self.processDestinationETA(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
        case "ActionDestinationDistance":
            self.processDestinationDistance(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
        case "ActionPOISearch":
            self.processPOISearch(result, response: response)
            ContextManager.sharedManager.addResponseToContext(response)
            ContextManager.sharedManager.currentContext = .ContextPOISearch
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
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
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
            if ContextManager.sharedManager.currentContext == .ContextEntertainment {
                DialogueManager.sharedManager.speechManager.pauseSpeech()
            }
            else{
                self.invalidCommandRequest()
            }
        case "Continuing":
            if ContextManager.sharedManager.currentContext == .ContextEntertainment {
                DialogueManager.sharedManager.speechManager.continueSpeech()
            }
            else{
                self.invalidCommandRequest()
            }
        case "Stoping":
            if ContextManager.sharedManager.currentContext == .ContextEntertainment {
                DialogueManager.sharedManager.speechManager.stopSpeech()
            }
            else{
                self.invalidCommandRequest()
            }
        case "Starting Over":
            if ContextManager.sharedManager.currentContext == .ContextEntertainment {
                DialogueManager.sharedManager.speechManager.sayText(ContentManager.sharedManager.currentContent)
            }
            else if ContextManager.sharedManager.currentContext == .ContextPOISearch {
                self.resetPOIInfo()
            }
            else{
                self.invalidCommandRequest()
            }
        case "Repeating":
            if ContextManager.sharedManager.currentContext == .ContextPOISearch {
                self.repeatPOIInfo()
            }
            else{
                self.invalidCommandRequest()
            }
        case "Going to Next":
            if ContextManager.sharedManager.currentContext == .ContextPOISearch {
                self.nextPOIInfo()
            }
            else{
                self.invalidCommandRequest()
            }
            
        case "Going to Previous":
            if ContextManager.sharedManager.currentContext == .ContextPOISearch {
                self.previousPOIInfo()
            }
            else{
                self.invalidCommandRequest()
            }
        case "Going to First":
            if ContextManager.sharedManager.currentContext == .ContextPOISearch {
                self.goToFirstPOIInfo()
            }
            else{
                self.invalidCommandRequest()
            }
        case "Going to Last":
            if ContextManager.sharedManager.currentContext == .ContextPOISearch {
                self.goToLastPOIInfo()
            }
            else{
                self.invalidCommandRequest()
            }
            
        default:
            break
        }
    }
    
    func invalidCommandRequest(){
        
    }
    
    // MARK: POI Related commands
    
    func processPOISearch(result:NSDictionary, response:AnyObject){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        let parameter = self.getParameter("poi", fromResult: result)
        MKMapViewManager.sharedManager.findPOI(parameter, near: MapViewManager.sharedManager.currentLocation())
        print("POI search with parameter: " + parameter)
        self.sayResponse(result)
        self.delegate?.resetAnnotations()
    }
    
    func resetPOIInfo(){
        self.delegate?.resetAnnotations()
        MKMapViewManager.sharedManager.resetDestinationInfo([])
        DialogueManager.sharedManager.speechManager.sayText("Resetting location search")
    }
    
    
    func repeatPOIInfo(){
        self.processDestinationInfo(poi: MKMapViewManager.sharedManager.currentPOI)
    }
    
    func nextPOIInfo(){
        if MKMapViewManager.sharedManager.currentDestinations.count > MKMapViewManager.sharedManager.currentDestinationIndex - 1 {
            MKMapViewManager.sharedManager.currentDestinationIndex += 1
            self.processDestinationInfo(poi: MKMapViewManager.sharedManager.currentPOI)
        }
        else{
            DialogueManager.sharedManager.speechManager.sayText("Sorry. This is the last \(MKMapViewManager.sharedManager.currentPOI) near by")
        }
    }
    
    func previousPOIInfo(){
        if MKMapViewManager.sharedManager.currentDestinationIndex > 0{
            MKMapViewManager.sharedManager.currentDestinationIndex -= 1
            self.processDestinationInfo(poi: MKMapViewManager.sharedManager.currentPOI)
        }
        else{
            DialogueManager.sharedManager.speechManager.sayText("Sorry. This the first \(MKMapViewManager.sharedManager.currentPOI)")
        }
    }
    
    func goToFirstPOIInfo(){
         MKMapViewManager.sharedManager.currentDestinationIndex  = 0
        self.processDestinationInfo(poi: MKMapViewManager.sharedManager.currentPOI)
    }

    func goToLastPOIInfo(){
        MKMapViewManager.sharedManager.currentDestinationIndex  = MKMapViewManager.sharedManager.currentDestinations.count - 1
        self.processDestinationInfo(poi: MKMapViewManager.sharedManager.currentPOI)
    }
    
    func processDestinationInfo(result:NSDictionary? = nil , response:AnyObject? = nil, poi:String ){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        if MKMapViewManager.sharedManager.currentDestinations.isEmpty{
            DialogueManager.sharedManager.speechManager.sayText("Sorry. I do not have any information on \(poi). Please tell me what you wish me to find.")
            return
        }
        if MKMapViewManager.sharedManager.currentDestinations.count > MKMapViewManager.sharedManager.currentDestinationIndex{
            let des = MKMapViewManager.sharedManager.currentDestinations[MKMapViewManager.sharedManager.currentDestinationIndex]
            let address = des.mapItem.placemark.addressDictionary
            var info = "There is a "
            if let name  = address?["Name"] as? String{
                info +=  name + " "
            }
            else{
                "There is a \(poi) "
            }
            
            if let street  = address?["Street"] as? String{
                info += "on " + street + " "
            }
            if let city = address?["City"] as? String{
                info += "in " + city + " "
            }
            DialogueManager.sharedManager.speechManager.sayText(info)
        }
        else{
            DialogueManager.sharedManager.speechManager.sayText("Sorry. There is no more \(poi) near by")
        }
    }
    
    func processDestinationETA(result:NSDictionary? = nil , response:AnyObject? = nil ){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        if MKMapViewManager.sharedManager.currentDestinations.isEmpty{
            DialogueManager.sharedManager.speechManager.sayText("Sorry there is no destination to find ETA")
            return
        }
        if let eta = MKMapViewManager.sharedManager.getCurrentDestinationETA(){
            DialogueManager.sharedManager.promptUser(.POIDestinationETAInfo,text: eta)
        }
        else{
            DialogueManager.sharedManager.promptUser(.POIDestinationETASearch)
            MKMapViewManager.sharedManager.findDirectionETAInfoForCurrentDestination(.ETA)
        }
    }
    
    
    func processDestinationDistance(result:NSDictionary? = nil, response:AnyObject? = nil ){
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        if MKMapViewManager.sharedManager.currentDestinations.isEmpty{
            DialogueManager.sharedManager.speechManager.sayText("Sorry there is no destination to find distance")
            return
        }
        if let dis = MKMapViewManager.sharedManager.getCurrentDestinationDistance(){
            DialogueManager.sharedManager.promptUser(.POIDestinationDistanceInfo,text: dis)
        }
        else{
            DialogueManager.sharedManager.promptUser(.POIDestinationDistanceSearch)
            MKMapViewManager.sharedManager.findDirectionETAInfoForCurrentDestination(.Distance)
        }
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


