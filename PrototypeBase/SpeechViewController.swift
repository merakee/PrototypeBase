//
//  SpeechViewController.swift
//  PrototypeBase
//
//  Created by Bijit on 11/23/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import PureLayout

class SpeechViewController: UIViewController , BSRSpeechRecognizerDelegate {
    
    var recordButton: UIButton!
    var transcriptionTextView: UITextView!
    var statusTextView: UITextView!
    
    
    // MARK: - View Set up
    override func loadView() {
        super.loadView()
        setView()
    }
    
    func setView(){
        // hide or show nav bar
        self.navigationController?.navigationBar.hidden = true
        
        // back ground color
        self.view.backgroundColor = UIColor.whiteColor()//appBlueColor
        
        statusTextView = UITextView.newAutoLayoutView()
        statusTextView.backgroundColor = UIColor.appGreenColor
        statusTextView.font = AppUIManager.sharedManager.appFont(14)
        self.view.addSubview(statusTextView)
        
        transcriptionTextView = UITextView.newAutoLayoutView()
        transcriptionTextView.backgroundColor = UIColor.appBlueColor
        transcriptionTextView.font = AppUIManager.sharedManager.appFont(14)
        self.view.addSubview(transcriptionTextView)
        
        recordButton = UIButton(type: .Custom)
        recordButton.setImage(UIImage(named: "RedMicButton"), forState: UIControlState.Normal)
        recordButton.addTarget(self, action: "onRecordButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(recordButton)
        
        self.layoutView()
    }
    
    func layoutView(){
        let gap:CGFloat = 10.0
        
        statusTextView.autoSetDimension(.Height, toSize: 80.0)
        statusTextView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(100.0,gap,gap,gap), excludingEdge: .Bottom)
        
        transcriptionTextView.autoSetDimension(.Height, toSize: 80.0)
        transcriptionTextView.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: gap)
        transcriptionTextView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: gap)
        transcriptionTextView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: statusTextView, withOffset: gap*2)
        
        recordButton.autoSetDimension(.Height, toSize: 80.0)
        recordButton.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Height, ofView: recordButton)
        recordButton.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        recordButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60.0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSpeechEngine()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Speech Engine Mathods
    func setupSpeechEngine(){
        let server = ServerManager.getServer(ServerManager.ServerType.EnglishAmazon)
        let endPoint = server["enpPoint"]
        print(server)
        print(endPoint)
        
        //BSRSpeechRecognizer.sharedInstance().apiConfig.serverURL = ServerManager.getServer(ServerManager.ServerType.EnglishAmazon)["]
        //BSRSpeechRecognizer.sharedInstance().apiConfig.streamingEndpoint =
        BSRSpeechRecognizer.sharedInstance().delegate = self
    }
    
    func speechRecognizer(speechRecognizer:BSRSpeechRecognizer, didChangeState state:BSRState) {
        switch state {
        case .Ready:
            self.statusTextView.text = "Recordering"
        case .Recognizing:
            self.statusTextView.text = "Recognizing"
        case .Off:
            self.statusTextView.text = "Recorder off"
        }
    }
    
    
    func speechRecognizer(voiceService:BSRSpeechRecognizer, didReceiveTranscription transcriptionResult:BSRTranscriptionResult, utteranceEnd ended:Bool, error:NSError?) {
        if (error != nil) {
            // Error during transcription
            print("Error during transcription: \(error!.localizedDescription)")
        } else {
            // Transcription successful, display transcription on UI.
            if let transcription = transcriptionResult.transcriptions[0] as? BSRTranscription {
                self.transcriptionTextView.text = transcription.transcription
            }
        }
    }
    
    // MARK: - Button Action methods
    func onRecordButtonPressed(sender:AnyObject) {
        print(BSRSpeechRecognizer.sharedInstance().recorderOn)
        if (BSRSpeechRecognizer.sharedInstance().recorderOn) {
            BSRSpeechRecognizer.sharedInstance().stopListening()
            stopFlashingbutton()
        } else {
            BSRSpeechRecognizer.sharedInstance().startListening()
            startFlashingbutton()
        }
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
    
}