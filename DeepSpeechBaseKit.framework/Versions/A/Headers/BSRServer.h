//
//  BSRServer.h
//  iOSSDK
//
//  Created by Kenny Liou on 10/19/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSREncoder.h"
#import "BSRTranscriptionResult.h"
#import "BSRApiConfig.h"
#import "BSRNetworkProtocol.h"

@class BSRServer;

@protocol BSRServerDelegate <NSObject>

- (void)server:(id<BSRNetworkProtocol>)server didReceiveTranscription:(BSRTranscriptionResult*)transcriptionResult utteranceEnd:(BOOL)ended error:(NSError*)error;

@end

@interface BSRServer : NSObject <BSRNetworkProtocol>

@property (weak, nonatomic) id<BSRServerDelegate> delegate;
@property (strong, nonatomic) id<BSREncoder> encoder;

@end
