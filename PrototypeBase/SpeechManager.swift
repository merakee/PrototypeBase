//
//  SpeechManager.swift
//  PrototypeBase
//
//  Created by Bijit on 12/21/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import Foundation

class SpeechManager: NSObject, AVSpeechSynthesizerDelegate{
    
    // MARK: - singleton
    static let sharedManager = SpeechManager()
    let speechSynthesizer:AVSpeechSynthesizer!
    
    private override init() {
        self.speechSynthesizer = AVSpeechSynthesizer()
        super.init()
        self.setSpeechSythesizer()
    }
    
    func setSpeechSythesizer(){
        self.speechSynthesizer.delegate =  self
    }
    func sayText(text:String?){
        self.stopSpeech()
        self.addTextToSpeech(text)
    }
    
    func addTextToSpeech(text:String?){
        if let textS = text {
            let speechUtterance = AVSpeechUtterance(string:textS)
            self.speechSynthesizer.speakUtterance(speechUtterance)
        }
    }
    
    func stopSpeech(){
        if self.speechSynthesizer.speaking{
            self.speechSynthesizer.stopSpeakingAtBoundary(.Immediate)
        }
    }
    
    func pauseSpeech(){
        self.speechSynthesizer.pauseSpeakingAtBoundary(.Word)
    }
    func continueSpeech(){
        if self.speechSynthesizer.paused {
            self.speechSynthesizer.continueSpeaking()
        }
    }
    // MARK: - AVSpeechSynthesizer Delegate methods
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer,
        didCancelSpeechUtterance utterance: AVSpeechUtterance){
            
    }
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer,
        didContinueSpeechUtterance utterance: AVSpeechUtterance){
            
    }
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer,
        didFinishSpeechUtterance utterance: AVSpeechUtterance){
            
    }
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer,
        didPauseSpeechUtterance utterance: AVSpeechUtterance){
            
    }
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer,
        didStartSpeechUtterance utterance: AVSpeechUtterance){
            
    }
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer,
        willSpeakRangeOfSpeechString characterRange: NSRange,
        utterance: AVSpeechUtterance){
            
    }
    
}
