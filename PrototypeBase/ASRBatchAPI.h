//
//  BSRBatchAPI.h
//  DemoV2
//
//  Created by Kenny Liou on 10/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <DeepSpeechBaseKit/DeepSpeechBaseKit.h>

@interface ASRBatchAPI : NSObject <BSRNetworkProtocol>

@property (weak, nonatomic) id<BSRServerDelegate> delegate;

+ (instancetype) sharedInstance;

- (void) sendData:(NSData *) data;
@end
