//
//  BSRAudioSampleInfo.h
//  DeepSpeechBaseKit
//
//  Created by Thuan Nguyen on 11/20/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRAudioSampleInfo : NSObject

@property (nonatomic, strong) NSNumber *sampleRate;
@property (nonatomic, strong) NSNumber *bitRate;
@property (nonatomic, strong) NSNumber *channel;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, assign) BOOL isLastSample;

- (instancetype)initWithSampleRate:(NSNumber*)sampleRate bitRate:(NSNumber*)bitRate channel:(NSNumber*)channel level:(NSNumber*)level isLast:(BOOL)isLast;

@end
