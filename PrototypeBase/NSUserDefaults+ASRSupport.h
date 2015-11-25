//
//  NSUserDefaults+ASRSupport.h
//  DemoV2
//
//  Created by Kenny Liou on 10/22/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <DeepSpeechBaseKit/DeepSpeechBaseKit.h>
#import "ASRServerConfig.h"

@interface NSUserDefaults (ASRSupport)

- (void) setServerConfig:(ASRServerConfig *)serverConfig withKey:(NSString *)key;
- (ASRServerConfig *) getServerConfigWithKey:(NSString *)key;

@end
