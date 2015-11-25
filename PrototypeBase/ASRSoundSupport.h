//
//  BSRSoundSupport.h
//  DemoV2
//
//  Created by Kenny Liou on 10/22/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ASRSoundSupportDelegate <NSObject>

- (void) onDataPlayerDidFinished;

@end

@interface ASRSoundSupport : NSObject

+ (void) addDelegate:(id<ASRSoundSupportDelegate>)delegate;
+ (void) playOpenSound;
+ (void) playSuccessSound;
+ (void) playFailSound;
+ (BOOL) isPlaying;
+ (void) stopPlaying;
+ (void) playData:(NSData *)data;

@end
