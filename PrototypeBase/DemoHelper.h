//
//  DemoHelper.h
//  DemoV2
//
//  Created by Kenny Liou on 10/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASRServerConfig.h"
#import <DeepSpeechBaseKit/DeepSpeechBaseKit.h>

#define kCustomSettingsUserPref @"kCustomSettingsUserPref"
#define kCustomSettingMaxConcurrencyKey @"kCustomSettingMaxConcurrencyKey"
#define kCustomSettingSampleRateKey @"kCustomSettingSampleRateKey"
#define kCustomSettingChunkSecondKey @"kCustomSettingChunkSecondKey"
#define kCustomSettingServerTimeoutKey @"kCustomSettingServerTimeoutKey"

@protocol DemoHelperDelegate <NSObject>

- (void) onTranscriptReceived:(NSString *)transcription utteranceEnded:(BOOL)ended;
- (void)speechRecognizer:(BSRSpeechRecognizer *)speechRecognizer didChangeState:(BSRState)state;
- (void) onEmailMessage:(NSString *)emailStatusMessage;
- (void) onPresentEmailController:(MFMailComposeViewController *)controller;
- (void) onDismissEmailController;
- (void) onNetworkError:(NSError *)error;
- (void) onLevelChanged:(float)level;

@end

@interface DemoHelper : NSObject

@property (nonatomic) BOOL useBv32;
@property (weak, nonatomic) id<DemoHelperDelegate> delegate;

+ (instancetype) sharedInstance;
- (NSString *) getInputName;
- (void) startRecognize;
- (void) stopRecognize;
- (void) resendSound;
- (void) replaySound;
- (void) updateServerConfig:(ASRServerConfig *) config;
- (int) sampleRate;
- (int) bitRate;
- (int) channel;
- (void) sendFeedback:(NSString *) lastTranscribedText;

- (void) viewDidAppear;
- (void) onAppEnterBackground;
- (void) onAppBecomeActive;
- (BSRApiConfig*)currentApiConfig;
- (BSRServerType)BSRServerTypeFromServerType:(ASRServerType)serverTyp;

@end
