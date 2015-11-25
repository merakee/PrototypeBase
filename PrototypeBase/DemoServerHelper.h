//
//  DemoServerHelper.h
//  DemoV2
//
//  Created by Kenny Liou on 10/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASRServerConfig.h"
#import <DeepSpeechBaseKit/DeepSpeechBaseKit.h>
#import "ASRServerConfigManager.h"

@interface DemoServerHelper : NSObject

@property (strong, nonatomic) ASRServerConfigManager * manager;

+ (instancetype) sharedInstance;
- (NSArray *) getServerList;
- (NSString *) getLastUpdatedTime;
- (ASRServerConfig *) currentServerConfig;
- (void) setCurrentServerConfig:(ASRServerConfig *)config;
- (void) fetchServerInfo:(void(^)(void))callback;

@end
