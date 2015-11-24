//
//  BSRApiConfig.h
//  DeepSpeechBaseKit
//
//  Created by Thuan Nguyen on 11/17/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDefaultSectionName @"Default"
#define kStreamingServerSectionName @"Streaming Server"
#define kFeedbackServerSectionName @"Feedback Server"
#define kMicrophoneSectionName @"Microphone"

#define kDefaultTimeout 60.0f
#define kDefaultMaxConcurrency 3
#define kDefaultServerName @"Chinese: deepspeech.baidu.com"
#define kDefaultServerURL @"http://deepspeech.baidu.com"
#define kDefaultTranscriptionEndpoint @"SpeechFrontEnd/Transcribe"
#define kDefaultFeedbackEndpoint @"SpeechFrontEnd/Feedback"
#define kDefaultLanguage @"zh_CN"
#define kDefaultServerType BSRServerTypeStream
#define kDefaultEncodingSupport NO
#define kDefaultSampleRate 8000.0f
#define kDefaultNumberOfConnections 3
#define kDefaultTimeout 60.0f
#define kDefaultChunkSecs 0.3f

typedef NS_ENUM(NSInteger, BSRServerType) {
    BSRServerTypeNone = 0,
    BSRServerTypeStream,
    BSRServerTypeBatch
};

// ----------------------------------------------------------------------
#pragma mark - BSRApiConfig interface
// ----------------------------------------------------------------------

@interface BSRApiConfig : NSObject

@property (nonatomic, assign) BSRServerType serverType;
@property (nonatomic, strong) NSNumber *sampleRate;
@property (nonatomic, strong) NSNumber *maxConcurrency;
@property (nonatomic, strong) NSNumber *defaultTimeout;
@property (nonatomic, strong) NSNumber *chunkSecond;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, assign) BOOL supportsEncoding;

@property (nonatomic, strong) NSString *serverName;
@property (nonatomic, strong) NSURL *serverURL;
@property (nonatomic, strong) NSString *streamingEndpoint;
@property (nonatomic, strong) NSString *feedbackEndpoint;

- (NSURL*)streamingEndpointURL;
- (NSURL*)feedbackEndpointURL;

@end
