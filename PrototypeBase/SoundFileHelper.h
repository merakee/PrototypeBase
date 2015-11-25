//
//  SoundFileHelper.h
//  DemoV2
//
//  Created by Kenny Liou on 10/26/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundFileHelper : NSObject

+ (NSMutableData *) createEmptyData;
+ (NSData *)writeWavHeader:(NSData *)data sampleRate:(int)sampleRate bitRate:(int)bitRate channel:(int)channel;

@end
