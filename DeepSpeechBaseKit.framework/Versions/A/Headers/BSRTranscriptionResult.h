//
//  BSRTranscriptionResult.h
//  DeepSpeechBaseKit
//
//  Created by Thuan Nguyen on 11/16/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - BSRtranscription

@interface BSRTranscription : NSObject

@property (nonatomic, strong) NSString *transcription;
@property (nonatomic, strong) NSString *transcriptionId;

@end

#pragma mark - BSRTranscriptionResult

@interface BSRTranscriptionResult : NSObject

@property (nonatomic, strong) NSString *hostName;
@property (nonatomic, assign) BOOL isLast;
@property (nonatomic, strong) NSNumber *latency;
@property (nonatomic, strong) NSNumber *sequenceId;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray *transcriptions;

- (instancetype)initWithDictionary:(NSDictionary*)dic;

@end
