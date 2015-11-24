//
//  BSRVadEngine.h
//  DeepSpeechBaseKit
//
//  Created by Thuan Nguyen on 11/11/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

typedef NS_ENUM(int, BSRVadError) {
    BSRVadErrorNone = 0,
    BSRVadErrorUnknown,
    BSRVadErrorNoSpeech,
    BSRVadErrorSpeechTooShort,
};

@protocol BSRVadEngine;

#pragma mark - BSRVadEngineDelegate

@protocol BSRVadEngineDelegate <NSObject>

@optional

- (void)didStartSpeechVadEngine:(id<BSRVadEngine>)vadEngine;
- (void)didEndSpeechVadEngine:(id<BSRVadEngine>)vadEngine;
- (void)vadEngine:(id<BSRVadEngine>)vadEngine didReceiveError:(BSRVadError)error;

@end

@protocol BSRVadEngine <NSObject>

@property(nonatomic, weak) id<BSRVadEngineDelegate> delegate;   // TODO: Don't make this public

- (void)initWithSampleRate:(int)sampleRate;
- (void)reset;
- (void)sendData:(NSData*)data;

@end