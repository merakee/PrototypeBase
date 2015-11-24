//
//  BSRStateHandler.h
//  DeepSpeechBaseKit
//
//  Created by Thuan Nguyen on 11/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

@class BSRAudioSampleInfo;

@protocol BSRStateHandler <NSObject>

@required

- (void)start;
- (void)stop;
- (void)onReceiveData:(NSData *)data audioInfo:(BSRAudioSampleInfo*)audioInfo;

@end