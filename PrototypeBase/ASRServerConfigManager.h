//
//  BSRServerConfigManager.h
//  DemoV2
//
//  Created by Kenny Liou on 10/21/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASRServerConfig.h"
#import <DeepSpeechBaseKit/DeepSpeechBaseKit.h>

@protocol ASRServerConfigManagerDelegate <NSObject>

- (void) serverConfigUpdated:(ASRServerConfig *) config;

@end

@interface ASRServerConfigManager : NSObject

@property (weak, nonatomic) id<ASRServerConfigManagerDelegate> delegate;
@property (strong, nonatomic) ASRServerConfig * currentServerConfig;

+ (instancetype) getDefaultConfigs;
- (instancetype) initWithJSON:(NSDictionary *)json;
- (NSTimeInterval) getTimeStamp;
- (NSArray *) getServerConfigs;
- (int) getServerCount;

- (ASRServerConfig *) currentServerConfigForLanguage:(NSString*)language;
- (void)setCurrentServerConfig:(ASRServerConfig *)currentServerConfig forLanguage:(NSString*)language;

@end