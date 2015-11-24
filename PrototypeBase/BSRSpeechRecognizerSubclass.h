//
//  BSRSpeechRecognizerSubclass.h
//  DeepSpeechBaseKit
//
//  Created by Thuan Nguyen on 11/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

@protocol BSRAudioRecorder;
@class BSRRecognizer;
@class BSRAPIManager;

typedef NS_ENUM(NSInteger, BSRSpeechRecognizerState) {
    BSRSpeechRecognizerStateOff,
    BSRSpeechRecognizerStateStarting,
    BSRSpeechRecognizerStateOn,
    BSRSpeechRecognizerStateRecognizing,
    BSRSpeechRecognizerStateRecognizeOn,
    BSRSpeechRecognizerStateStopRecognizing,
    BSRSpeechRecognizerStateStopping,
};

@interface BSRSpeechRecognizer ()

@property (strong, nonatomic) NSString * lastTranscribedText;
@property (strong, nonatomic) NSMutableDictionary * stateMap;
@property (nonatomic, strong) id<BSRAudioRecorder> recorder;
@property (strong, nonatomic) BSRRecognizer * recognizer;
@property (nonatomic) BSRSpeechRecognizerState state;
@property (nonatomic) BOOL recognizeImmediately;
@property (nonatomic, strong) id<BSRVadEngine> vadEngine;
@property (nonatomic, strong) BSRAPIManager * apiManager;
@property (nonatomic, strong) BSRApiConfig *apiConfig;
@property (nonatomic, strong) id<BSREncoder> encoder;
@property (nonatomic, strong) BSRAudioSampleInfo *lastSampleInfo;
@property (nonatomic, strong) id<BSRTriggerWordEngine> triggerWordEngine;

- (void)addBatchServer:(id<BSRNetworkProtocol>)server;
- (void)resendData:(NSData *)data;
- (void) turnRecorderOn;

@end
