//
//  SpeechViewController.swift
//  PrototypeBase
//
//  Created by Bijit on 11/23/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import PureLayout

class SpeechViewController: UIViewController , BSRSpeechRecognizerDelegate, BSRServerDelegate {
    
    enum SpeechServerLanguage: String {
        case English = "en_US", Chinese = "zh_CN"
        var text: String {
            switch self {
            case .English:
                return "English"
            case .Chinese:
                return "中文"
                //            default:
                //                return ""
            }
        }
    }
    
    
    var recordButton: UIButton!
    var transcriptionTextView: UITextView!
    var statusTextView: UITextView!
    
    // speech server related
    var speechRecognizer: BSRSpeechRecognizer!
    var batchServer: ASRBatchAPI!
    var vadClient = BSRVadClient!()
    var soundData = NSMutableData!()
    var lastSampleAudioInfo = BSRAudioSampleInfo!()
    var dataSent = false
    var language = SpeechServerLanguage.Chinese
    
    // MARK: - View Set up
    override func loadView() {
        super.loadView()
        setView()
    }
    
    func setView(){
        // navbar
        self.setNavBar()
        
        // back ground color
        self.view.backgroundColor = UIColor.whiteColor()//appBlueColor
        
        transcriptionTextView = UITextView.newAutoLayoutView()
        transcriptionTextView.backgroundColor = UIColor.appBlueColor
        transcriptionTextView.font = AppUIManager.sharedManager.appFont(14)
        transcriptionTextView.text = "Transcript ...."
        self.view.addSubview(transcriptionTextView)
        
        statusTextView = UITextView.newAutoLayoutView()
        statusTextView.backgroundColor = UIColor.appGreenColor
        statusTextView.font = AppUIManager.sharedManager.appFont(14)
        statusTextView.text = "Touch the button to start..."
        self.view.addSubview(statusTextView)
        
        recordButton = UIButton(type: .Custom)
        recordButton.setImage(UIImage(named: "RedMicButton"), forState: UIControlState.Normal)
        recordButton.addTarget(self, action: "onRecordButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(recordButton)
        
        self.layoutView()
    }
    
    func setNavBar(){
        // hide or show nav bar
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.appBlueColor
        self.title = self.language.text
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"", style: .Plain, target: self, action: "toggleLanguage:")
    }
    
    func layoutView(){
        let gap:CGFloat = 10.0
        
        transcriptionTextView.autoSetDimension(.Height, toSize:200.0)
        transcriptionTextView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(80.0,gap,gap,gap), excludingEdge: .Bottom)
        
        statusTextView.autoSetDimension(.Height, toSize: 80.0)
        statusTextView.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: gap)
        statusTextView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: gap)
        statusTextView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: transcriptionTextView, withOffset: gap*2)
        
        recordButton.autoSetDimension(.Height, toSize: 80.0)
        recordButton.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Height, ofView: recordButton)
        recordButton.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        recordButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60.0)
    }
    
    func updateNavbar(){
        switch self.language{
        case .English:
            self.navigationItem.leftBarButtonItem?.title = SpeechServerLanguage.Chinese.text
        case .Chinese:
            self.navigationItem.leftBarButtonItem?.title = SpeechServerLanguage.English.text
        }
        
        self.title = self.language.text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateNavbar()
        self.setupSpeechServer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Speech Engine setup methods Mathods
    func setupSpeechServer(){
        self.batchServer = ASRBatchAPI.sharedInstance()
        self.batchServer.delegate = self
        self.speechRecognizer = BSRSpeechRecognizer.sharedInstance()
        self.speechRecognizer.addBatchServer(self.batchServer)
        self.speechRecognizer.delegate = self
        self.soundData = SoundFileHelper.createEmptyData()
    }
    
    func updateServerConfig () {
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        let config = DemoServerHelper.sharedInstance().manager.currentServerConfigForLanguage(self.language.rawValue)
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        
        if  config != nil {
            let appConfig = BSRSpeechRecognizer.sharedInstance().apiConfig
            if let endpointString = config.endpoint {
                
                
                if let url = NSURL(string:endpointString) {
                    var hostURL = url.scheme + "://" + url.host!
                    if  url.port != nil {
                        hostURL += ":" + String(url.port)
                    }
                    
                    appConfig.serverURL = NSURL(string:hostURL)
                    appConfig.streamingEndpoint = url.path
                }
            }
            print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
            let serverType = self.BSRServerTypeFromServerType(config.serverType)
            appConfig.serverType = serverType
            print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
            appConfig.serverName = config.name;
            print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
            appConfig.language = config.language;
            print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
            //print(config.encodingSupport)
            appConfig.supportsEncoding = config.encodingSupport == nil ? false : config.encodingSupport.boolValue
            
        }
    }
    
    func BSRServerTypeFromServerType(serverType:ASRServerType) -> BSRServerType {
        switch serverType {
        case .STREAM:
            return BSRServerType.Stream
        case .BATCH:
            return BSRServerType.Batch
            //        default:
            //            return BSRServerType.None
        }
        
        // return BSRServerType.None
    }
    
    // MARK: - Batch Server Methods
    func speechRecognizer(speechRecognizer:BSRSpeechRecognizer, didRecognizeAudioData audioData:NSData, audioInfo:BSRAudioSampleInfo){
        let type = speechRecognizer.apiConfig.serverType
        self.soundData.appendData(audioData)
        self.lastSampleAudioInfo = audioInfo
        
        if (audioInfo.isLastSample && (type != BSRServerType.Stream) && !self.dataSent) {
            self.dataSent = true
            self.sendDataToBatchServer()
        }
        
        if (!audioInfo.isLastSample) {
            self.dataSent = false
        }
        
        //self.recordButtonContainerView.backgroundColor = [UIColor colorWithRed:255.0*audioInfo.level.floatValue green:0.0 blue:0.0 alpha:1.0];
    }
    
    func sendDataToBatchServer(){
        self.batchServer.sendData(self.getSoundfileWithHeader())
    }
    
    func getSoundfileWithHeader() -> NSData {
        return SoundFileHelper.writeWavHeader(self.soundData,
            sampleRate:Int32((self.lastSampleAudioInfo.sampleRate.integerValue)),
            bitRate:Int32((self.lastSampleAudioInfo.bitRate.integerValue)),
            channel:Int32((self.lastSampleAudioInfo.channel.integerValue)))
    }
    
    // MARK: - BSRSpeechRecognizerDelegate methods
    func speechRecognizer(speechRecognizer:BSRSpeechRecognizer, didChangeState state:BSRState) {
        switch state {
        case .Ready:
            self.statusTextView.text = "Recordering"
            //startFlashingbutton()
        case .Recognizing:
            self.statusTextView.text = "Recognizing"
            //startFlashingbutton()
        case .Off:
            self.statusTextView.text = "Recorder off"
            stopFlashingbutton()
        }
    }
    
    
    func speechRecognizer(voiceService:BSRSpeechRecognizer?, didReceiveTranscription transcriptionResult:BSRTranscriptionResult, utteranceEnd ended:Bool, error:NSError?) {
        if (error != nil) {
            // Error during transcription
            print("Error during transcription: \(error!.localizedDescription)")
        } else {
            // Transcription successful, display transcription on UI.
            if let transcription = transcriptionResult.transcriptions[0] as? BSRTranscription {
                self.transcriptionTextView.text = transcription.transcription.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            }
        }
    }
    
    func vadEngineForSpeechRecognizer(speechRecognizer:BSRSpeechRecognizer) -> BSRVadEngine {
        if  self.vadClient == nil  {
            self.vadClient = BSRVadClient()
        }
        return self.vadClient;
    }
    
    // MARK: - BSRServerDelegate
    func server(server:BSRNetworkProtocol, didReceiveTranscription transcriptionResult:BSRTranscriptionResult, utteranceEnd ended:Bool, error:NSError){
        // Callback from batch server
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        self.speechRecognizer(nil,didReceiveTranscription:transcriptionResult,utteranceEnd:ended,error:error)
    }
    
    // MARK: - Button Action methods
    func onRecordButtonPressed(sender:AnyObject) {
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        if (self.speechRecognizer.recorderOn) {
            self.speechRecognizer.stopListening()
            self.speechRecognizer.state = .Off
            stopFlashingbutton()
        } else {
            self.startListening()
        }
    }
    
    func startListening(){
       // print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        self.updateServerConfig()
        self.soundData = SoundFileHelper.createEmptyData()
        self.lastSampleAudioInfo = nil
        self.speechRecognizer.startListening()
        startFlashingbutton()
    }
    
    func startFlashingbutton() {
        recordButton.alpha = 1
        
        UIView.animateWithDuration(1.0 , delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.AllowUserInteraction], animations: {
            
            self.recordButton.alpha = 0.25
            
            }, completion: {Bool in
        })
    }
    
    func stopFlashingbutton() {
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.BeginFromCurrentState], animations: {self.recordButton.alpha = 1}, completion: {Bool in})
    }
    
    func toggleLanguage(sender:UIBarButtonItem){
        self.language = self.language == .English ? .Chinese : .English
        //print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        self.updateServerConfig()
        self.updateNavbar()
    }
    
}