//
//  BSRSoundSupport.m
//  DemoV2
//
//  Created by Kenny Liou on 10/22/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "ASRSoundSupport.h"

static NSString * const kOpenWav =      @"open.wav";
static NSString * const kSuccessWav =   @"success.wav";
static NSString * const kFailureWav =   @"failure.wav";

@import AVFoundation;

@interface ASRSoundSupport() <AVAudioPlayerDelegate>

@property (weak, nonatomic) id<ASRSoundSupportDelegate> delegate;
@property (strong, nonatomic) AVAudioPlayer * audioPlayer;

@end

@implementation ASRSoundSupport

+ (instancetype) sharedInstance
{
    static ASRSoundSupport * soundSupport = NULL;
    if (!soundSupport) {
        soundSupport = [[ASRSoundSupport alloc] init];
    }
    
    return soundSupport;
}

+ (void) playOpenSound
{
    [[ASRSoundSupport sharedInstance] playSoundFromResource:kOpenWav];
}

+ (void) playSuccessSound
{
    [[ASRSoundSupport sharedInstance] playSoundFromResource:kSuccessWav];
}

+ (void) playFailSound
{
    [[ASRSoundSupport sharedInstance] playSoundFromResource:kFailureWav];
}

+ (void) playData:(NSData *)data
{
    [[ASRSoundSupport sharedInstance] playData:data];
}

+ (BOOL) isPlaying
{
    return [[[ASRSoundSupport sharedInstance] audioPlayer] isPlaying];
}

+ (void) stopPlaying
{
    ASRSoundSupport * support = [ASRSoundSupport sharedInstance];
    [[support audioPlayer] stop];
    [support setAudioPlayer:NULL];
}

- (void) playData:(NSData *)data
{
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    
    NSArray * available = [audioSession availableInputs];
    
    if ([available count] < 2) { // if only have speaker
        [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
    }
    
    [self setAudioPlayer:[[AVAudioPlayer alloc] initWithData:data error:0]];
    [self.audioPlayer setDelegate:self];
    
    [self.audioPlayer play];
}

- (void) playSoundFromResource:(NSString*)res {
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], res];
    NSURL *url = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    [self playSoundUrl:url];
}

- (void) playSoundUrl:(NSURL*)url {
    // set up audio takes time (about 0.2s on iphone 6) in the first time,
    // dispatch it for better immediate ui responsiveness
    dispatch_async (dispatch_get_main_queue(), ^{
        // set up audio
        [self setAudioPlayer:[[AVAudioPlayer alloc] initWithContentsOfURL:url fileTypeHint:@"wav" error:nil]];
        [self.audioPlayer setDelegate:self];
        [self.audioPlayer play];
    });
}

+ (void) addDelegate:(id<ASRSoundSupportDelegate>)delegate
{
    [[ASRSoundSupport sharedInstance] setDelegate:delegate];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
        
        NSArray * available = [audioSession availableInputs];
        
        if ([available count] < 2) { // if only have speaker
            [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionAllowBluetooth error:nil];
        }
        
        
        [self.delegate onDataPlayerDidFinished];
    }
}


@end
