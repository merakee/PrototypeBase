//
//  BSRMicSupport.h
//  DemoV2
//
//  Created by Kenny Liou on 10/22/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "BSRApiConfig.h"
#import "BSRServer.h"
#import "BSREncoder.h"
#import "BSRVadEngine.h"
#import "BSRAudioSampleInfo.h"
#import "BSRSpeechRecognizerError.h"
#import "BSRTriggerWordEngine.h"

typedef NS_ENUM(NSInteger, BSRState) {
    BSRStateOff = 0,
    BSRStateReady,
    BSRStateRecognizing
};

@class BSRSpeechRecognizer;

#pragma mark - BSRVoiceRecognizerDelegate protocol

/*!
 @protocol BSRSpeechRecognizerDelegate
 
 @brief Delegate callback protocol for BSRSpeechRecognizer
 */
@protocol BSRSpeechRecognizerDelegate <NSObject>

@required

/*!
 @brief This method returns back the transcription received from the server or any errors that may have occurred.
 
 @param speechRecognizer Reference to speechRecognizer
 @param transcriptionResult The transcription result.  Nil if there was an error
 @param ended Specifies if the user stops speaking
 @param error Specifies any errors that may have occured during transcription.
 
 */
- (void)speechRecognizer:(BSRSpeechRecognizer*)speechRecognizer didReceiveTranscription:(BSRTranscriptionResult*)transcriptionResult utteranceEnd:(BOOL)ended error:(NSError*)error;

@optional

/*!
 @brief Method called when speech recognizer starts
 
 @param speechRecognizer Reference to speechRecognizer
 */
- (void)speechRecognizer:(BSRSpeechRecognizer *)speechRecognizer didChangeState:(BSRState)state;

/*!
 @brief Method called when speech recognizer starts to recognize audio data
 
 @param speechRecognizer Reference to speechRecognizer
 @param audioData Audio data that was recognized
 @param audioInfo Information about the audio data
 */
- (void)speechRecognizer:(BSRSpeechRecognizer*)speechRecognizer didRecognizeAudioData:(NSData*)audioData audioInfo:(BSRAudioSampleInfo*)audioInfo;

/*!
 @brief Delegate implements this method to signal speechRecognizer that the recorder has been virtually muted.
 
 @discussion
 Speech recognizer will not send any audio data to the server if delegate implements this method and returns a YES
 
 @param speechRecognizer Reference to speechRecognizer
 */
- (BOOL)isMutedForSpeechRecognizer:(BSRSpeechRecognizer*)speechRecognizer;

/*!
 @brief Method which allows delegate to specify a custom audio encoder
 
 @param speechRecognizer Reference to speechRecognizer
 */
- (id<BSREncoder>)audioEncoderForSpeechRecognizer:(BSRSpeechRecognizer*)speechRecognizer;

/*!
 @brief Method which allows delegate to specify a custom VAD engine
 
 @param speechRecognizer Reference to speechRecognizer
 */
- (id<BSRVadEngine>)vadEngineForSpeechRecognizer:(BSRSpeechRecognizer*)speechRecognizer;

@end

#pragma mark - BSRSpeechRecognizer interface

@interface BSRSpeechRecognizer : NSObject

@property (weak, nonatomic) id<BSRSpeechRecognizerDelegate> delegate;
@property (nonatomic, assign, readonly, getter=isRecorderOn) BOOL recorderOn;

+ (instancetype)sharedInstance;

/*!
 @brief Method which allows delegate to add a new Trigger Word engine
 
 @param triggerWord Custom trigger word engine
 */
- (void)addTriggerWordEngine:(id<BSRTriggerWordEngine>)triggerWordEngine;

/*!
 @brief Signals speech recognizer to start
 */
- (void)startListening;

/*!
 @brief Signals speech recognizer to stop
 */
- (void)stopListening;

/*!
 @brief Sends a transcription feedback to the server
 
 @discussion
 Allows clients to send transcription feedback to the server.  This will help the server improve accurracy on future transcriptions.
 
 @param transcriptionResult The transcription result client wants to send feedback on
 @param choiceIndex The index of the transcription results that the user selected
 @param completion Completion blocked called after feedback request was sent to server.  Sets the "error" parameter in cases where the request has an error
 */
- (void)sendFeedbackToTranscriptionResult:(BSRTranscriptionResult*)transcriptionResult choiceIndex:(NSInteger)choiceIndex completion:(void(^)(NSError* error))completion;

@end
