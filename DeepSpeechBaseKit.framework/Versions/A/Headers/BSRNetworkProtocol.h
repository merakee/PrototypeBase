//
//  BSRNetworkProtocol.h
//  DeepSpeechBaseKit
//
//  Created by Thuan Nguyen on 11/19/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

typedef enum {
    BSRSampleRateNone = 0,
    BSRSampleRate8k,
    BSRSampleRate16k,
} BSRSampleRate;

@protocol BSRNetworkProtocol <NSObject>

- (void) setServerSetting:(BSRApiConfig *)apiConfig;
- (void) sendData:(NSData *) data isLast:(BOOL)isLast sampleRate:(BSRSampleRate) rate;

@end
