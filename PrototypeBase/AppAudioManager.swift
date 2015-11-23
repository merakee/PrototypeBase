//
//  AppAudioManager.swift
//  PrototypeBase
//
//  Created by Bijit on 11/17/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import AVFoundation

class AppAudioManager {
    // MARK: - singleton
    static let sharedManager = AppAudioManager()
    private init() {
    }
    
    // MARK: - util methods
    func playSoundFromFile(file:String, ofType type:String) -> AVAudioPlayer? {
        //let filePath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(file, ofType:type)!)
        let filePath = NSBundle.mainBundle().URLForResource(file, withExtension: type)!
        print(filePath)
        
        var audioPlayer: AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: filePath)
        }
        catch {
            // handle error here
            print("Cannot play audio file...Error!")
            return nil
        }
        audioPlayer!.prepareToPlay()
       // audioPlayer!.play()
        
        return audioPlayer
    }
    
}
