//
//  DemoHelper.m
//  DemoV2
//
//  Created by Kenny Liou on 10/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "DemoHelper.h"
#import "InputSupport.h"
#import "DemoServerHelper.h"
#import "ASRBatchAPI.h"
#import "SoundFileHelper.h"
#import "ASRSoundSupport.h"
#import "ASRServerConfigManager.h"

#import <DeepSpeechBaseKit/BSRBv32Encoder.h>

#import <DeepSpeechBaseKit/DeepSpeechBaseKit.h>
#import <DeepSpeechBaseKit/BSRVadClient.h>
#import "BSRSpeechRecognizerSubclass.h" // Note this is a private header file, it is linked using "User Header Search Path" in the Demo project

static NSString * const kFeedbackEmail = @"svail-product@baidu.com";

@interface DemoHelper() <BSRSpeechRecognizerDelegate, BSRServerDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) BSRSpeechRecognizer * srSupport;
@property (strong, nonatomic) NSMutableData * soundData;
@property (strong, nonatomic) ASRBatchAPI * batchServer;
@property (nonatomic, strong) BSRVadClient *vadClient;
@property (nonatomic, strong) BSRTranscriptionResult *lastTranscriptionResult;

@property (nonatomic) int sampleRate;
@property (nonatomic) int bitRate;
@property (nonatomic) int channel;
@property (nonatomic) BOOL dataSent;

@end

@implementation DemoHelper

+ (instancetype) sharedInstance
{
    static DemoHelper * helper = NULL;
    if (!helper) {
        helper = [[DemoHelper alloc] init];
    }
    
    return helper;
}

- (BSRSpeechRecognizer *) srSupport
{
    if (!_srSupport) {
        _srSupport = [BSRSpeechRecognizer sharedInstance];
        [_srSupport setDelegate:self];
        [_srSupport addBatchServer:self.batchServer];
        
        NSDictionary *storedCustomSettings = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kCustomSettingsUserPref];
        if (storedCustomSettings != nil) {
            _srSupport.apiConfig.maxConcurrency = [storedCustomSettings objectForKey:kCustomSettingMaxConcurrencyKey];
            _srSupport.apiConfig.sampleRate = [storedCustomSettings objectForKey:kCustomSettingSampleRateKey];
            _srSupport.apiConfig.chunkSecond = [storedCustomSettings objectForKey:kCustomSettingChunkSecondKey];
            _srSupport.apiConfig.defaultTimeout = [storedCustomSettings objectForKey:kCustomSettingServerTimeoutKey];
        }
    }
    
    return _srSupport;
}

- (ASRBatchAPI *) batchServer
{
    if (!_batchServer) {
        _batchServer = [ASRBatchAPI sharedInstance];
        [_batchServer setDelegate:self];
    }
    
    return _batchServer;
}

- (void) viewDidAppear
{
    [self.srSupport setDelegate:self];
}

- (void) startRecognize
{
    NSLog(@"startRecognize timestamp %@", [NSDate date]);
    [self.srSupport startListening];
    [self setSoundData:NULL];
    NSLog(@"startRecognize timestamp %@", [NSDate date]);
}

- (void) stopRecognize
{
    [self.srSupport stopListening];
}

- (NSString *) getInputName
{
    return [InputSupport inputName];
}

- (NSMutableData *) soundData
{
    if (!_soundData) {
        _soundData = [SoundFileHelper createEmptyData];
    }
    
    return _soundData;
}

- (void)server:(id<BSRNetworkProtocol>)server didReceiveTranscription:(BSRTranscriptionResult*)transcriptionResult utteranceEnd:(BOOL)ended error:(NSError*)error {
    // Callback from batch server
    [self handleTranscriptionResult:transcriptionResult utteranceEnd:ended error:error];
}

- (void) speechRecognizer:(BSRSpeechRecognizer*)speechRecognizer didReceiveTranscription:(BSRTranscriptionResult*)transcriptionResult utteranceEnd:(BOOL)ended error:(NSError*)error {
    // Callback from streaming server
    [self handleTranscriptionResult:transcriptionResult utteranceEnd:ended error:error];
}

- (void)handleTranscriptionResult:(BSRTranscriptionResult*)transcriptionResult utteranceEnd:(BOOL)ended error:(NSError*)error {
    if (error) {
        [self.delegate onNetworkError:error];
    } else {
        self.lastTranscriptionResult = transcriptionResult;
        
        BSRTranscription *firstTranscription = [transcriptionResult.transcriptions firstObject];
        [self.delegate onTranscriptReceived:firstTranscription.transcription utteranceEnded:ended];
    }
}

- (void)speechRecognizer:(BSRSpeechRecognizer *)speechRecognizer didChangeState:(BSRState)state {
    [self.delegate speechRecognizer:speechRecognizer didChangeState:state];
}

- (id<BSREncoder>)audioEncoderForSpeechRecognizer:(BSRSpeechRecognizer*)speechRecognizer {
    if (self.useBv32) {
        return [[BSRBv32Encoder alloc] init];
    } else {
        return nil;
    }
}

- (id<BSRVadEngine>)vadEngineForSpeechRecognizer:(BSRSpeechRecognizer*)speechRecognizer {
    if (!self.vadClient) {
        self.vadClient = [[BSRVadClient alloc] init];
    }
    return self.vadClient;
}

- (void) speechRecognizer:(BSRSpeechRecognizer*)speechRecognizer didRecognizeAudioData:(NSData*)audioData audioInfo:(BSRAudioSampleInfo*)audioInfo
{
    [self.soundData appendData:audioData];
    
    BSRServerType type = self.srSupport.apiConfig.serverType;
    NSNumber * sampleRate = audioInfo.sampleRate;
    NSNumber * bitRate = audioInfo.bitRate;
    NSNumber * channel = audioInfo.channel;
    NSNumber * level = audioInfo.level;
    BOOL last = audioInfo.isLastSample;
    
    [self setSampleRate:sampleRate.intValue];
    [self setBitRate:bitRate.intValue];
    [self setChannel:channel.intValue];

    if (last && (type != BSRServerTypeStream) && !self.dataSent) {
        [self sendDataToBatchServer];
    }
    
    [self.delegate onLevelChanged:level.floatValue];
    
    if (!last) {
        [self setDataSent:NO];
    }
}

- (NSData *) getSoundfileWithHeader
{
    return [SoundFileHelper writeWavHeader:self.soundData
                                sampleRate:self.sampleRate
                                   bitRate:self.bitRate
                                   channel:self.channel];
}

- (void) resendSound
{
    ASRServerConfig * config = [[DemoServerHelper sharedInstance] currentServerConfig];
    
    if ([config serverType] == ASR_STREAM) {
        
        [self.srSupport resendData:self.soundData];
        
    } else {
        [self setDataSent:NO];
        [self.batchServer sendData:[self getSoundfileWithHeader]];
        [self setDataSent:YES];
    }
}

- (void) sendDataToBatchServer
{
    [self.batchServer sendData:[self getSoundfileWithHeader]];
}

- (void) sendFeedback:(NSString *) lastTranscribedText
{
    if ([MFMailComposeViewController canSendMail]) {
        NSMutableData *wavData = [[self getSoundfileWithHeader] mutableCopy];
        [self showEmailWithWavData:[wavData mutableBytes] len:((int)(wavData.length)) transcription:lastTranscribedText];
    } else {
        [self.delegate onEmailMessage:@"sorry, can only send feedback when there is email account associated in your device."];
    }
}

- (void)showEmailWithWavData:(unsigned char*)buffer
                         len:(int)len
               transcription:(NSString*)transcription
{
    
    DemoServerHelper * serverSupport = [DemoServerHelper sharedInstance];
    
    NSNumber* concurrency = [self.srSupport.apiConfig maxConcurrency];
    NSNumber* sampleRate = [self.srSupport.apiConfig sampleRate];
    NSNumber* chunkSec = NULL;
    NSString * currentServerName = [[serverSupport currentServerConfig] name];
    
    NSString *emailTitle = [NSString stringWithFormat:@"IOS-ASRDEMO-BADCASE-v%@-%@-%d",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], currentServerName, len];
    NSString *messageBody = [NSString stringWithFormat:@"transcribed txt is: %@\nconcurrency: %@\nsample rate: %@\nchunk size: %@(s)\n\nyour report:", transcription, concurrency, sampleRate, chunkSec];
    NSArray *toRecipents = [NSArray arrayWithObject:kFeedbackEmail];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Add attachment
    if (len > 0) {
        [mc addAttachmentData:[NSData dataWithBytes:buffer length:len] mimeType:@"audio/wav" fileName:@"audio.wav"];
    }
    
    // Present mail view controller on screen
    [self.delegate onPresentEmailController:mc];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            [self.delegate onEmailMessage:@"Mail sent, thanks!"];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            [self.delegate onEmailMessage:[NSString stringWithFormat:@"Mail sent failure: %@", [error localizedDescription]]];
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self.delegate onDismissEmailController];
}

- (void) replaySound
{
    [ASRSoundSupport playData:[SoundFileHelper writeWavHeader:self.soundData sampleRate:self.sampleRate bitRate:self.bitRate channel:self.channel]];
}

- (void) updateServerConfig:(ASRServerConfig *) config
{
    if (config != nil) {
        BSRApiConfig *appConfig = self.srSupport.apiConfig;
        
        NSString *endpointString = config.endpoint;
        if (endpointString != nil) {
            NSURL *url = [NSURL URLWithString:endpointString];
            if (url != nil) {
                NSString *portString = url.port != nil ? [NSString stringWithFormat:@":%@", url.port] : @"";
                NSString *hostURL = [NSString stringWithFormat:@"%@://%@%@", url.scheme, url.host, portString];
                appConfig.serverURL = [NSURL URLWithString:hostURL];
                appConfig.streamingEndpoint = url.path;
            }
        }
        
        BSRServerType serverType = [self BSRServerTypeFromServerType:config.serverType];
        appConfig.serverType = serverType;
        appConfig.serverName = config.name;
        appConfig.language = config.language;
        appConfig.supportsEncoding = [config.encodingSupport boolValue];
    }
}

- (BSRServerType)BSRServerTypeFromServerType:(ASRServerType)serverType {
    BSRServerType BSRServerType = BSRServerTypeNone;
    switch (serverType) {
        case ASR_STREAM:
            BSRServerType = BSRServerTypeStream;
            break;
        case ASR_BATCH:
            BSRServerType = BSRServerTypeBatch;
            break;
        default:
            break;
    }
    
    return BSRServerType;
}

- (int)sampleRate
{
    return _sampleRate;
}

- (int)bitRate
{
    return _bitRate;
}

- (int)channel
{
    return _channel;
}

- (void) onAppEnterBackground
{

}

- (void) onAppBecomeActive
{

}

- (BSRApiConfig*)currentApiConfig {
    return self.srSupport.apiConfig;
}

@end
