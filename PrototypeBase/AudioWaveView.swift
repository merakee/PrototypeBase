//
//  AudioWaveView.swift
//  PrototypeBase
//
//  Created by Bijit on 11/25/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import EZAudio

class AudioWaveView: UIView, EZMicrophoneDelegate {
    /**
     Use a OpenGL based plot to visualize the data coming in
     */
    weak var audioPlot: EZAudioPlotGL!
    /**
     The microphone component
     */
    var  microphone:EZMicrophone!
    /**
     The recorder component
     */
    var recorder:EZRecorder!
    
    // MARK: - init methods
    convenience init(){
        self.init(frame:CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.microphone = EZMicrophone(delegate: self, startsImmediately: true)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
    //MARK: - EZMicrophoneDelegate callbacks
    
    @objc func microphone(microphone: EZMicrophone, hasAudioReceived buffer:UnsafePointer<Float>, withBufferSize bufferSize:UInt32,    withNumberOfChannels numberOfChannels:UInt32) {
        dispatch_async(dispatch_get_main_queue()) {
            // Updates the audio plot with the waveform data
            self.audioPlot.updateBuffer(buffer[0], withBufferSize: bufferSize)
        }
    }
    
    func microphone(microphone:EZMicrophone, hasAudioStreamBasicDescription audioStreamBasicDescription:AudioStreamBasicDescription) {
        // The AudioStreamBasicDescription of the microphone stream. This is useful when configuring the EZRecorder or telling another component what audio format type to expect.
        
        // We can initialize the recorder with this ASBD
        //self.recorder = EZRecorder.recorderWithDestinationURL:[self testFilePathURL]
        //andSourceFormat:audioStreamBasicDescription];
        
    }
    
    func microphone(microphone:EZMicrophone, hasBufferList bufferList:AudioBufferList, withBufferSize bufferSize:UInt32,
        withNumberOfChannels numberOfChannels:UInt32) {
            
            // Getting audio data as a buffer list that can be directly fed into the EZRecorder. This is happening on the audio thread - any UI updating needs a GCD main queue block. This will keep appending data to the tail of the audio file.
            if self.isRecording {
                self.recorder.appendDataFromBufferList(bufferList, withBufferSize: bufferSize)
            }
    }
    
}
