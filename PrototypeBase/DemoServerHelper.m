//
//  DemoServerHelper.m
//  DemoV2
//
//  Created by Kenny Liou on 10/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "DemoServerHelper.h"
#import "ASRServerConfigManager.h"

static NSString * const kServerSettingUrl =             @"https://svail-api.baidu.com/getapi.json";
static NSString * const kLastUpdateTime =               @"lastupdatetime";

static float const kServerTimeout = 60.0f;

@interface DemoServerHelper()

@property (strong, nonatomic) NSURLSession * urlSession;
@property (strong, nonatomic) NSURLRequest * urlRequest;

@end

@implementation DemoServerHelper

+ (instancetype) sharedInstance
{
    static DemoServerHelper * support = NULL;
    if (!support) {
        support = [[DemoServerHelper alloc] init];
    }
    
    return support;
}

- (ASRServerConfig *) currentServerConfig
{
    return [self.manager currentServerConfig];
}

- (ASRServerConfigManager *) manager
{
    if (!_manager) {
        _manager = [ASRServerConfigManager getDefaultConfigs];
    }
    
    return _manager;
}

- (NSArray *) getServerList
{
    return [self.manager getServerConfigs];
}

- (NSString *) getLastUpdatedTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLastUpdateTime];
}

- (void) saveTime
{
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * timeString = [outputFormatter stringFromDate:now];
    
    [[NSUserDefaults standardUserDefaults] setObject:timeString forKey:kLastUpdateTime];
}

- (void) setCurrentServerConfig:(ASRServerConfig *)config
{
    [self.manager setCurrentServerConfig:config];
}

#pragma mark Fetch server info

- (void) fetchServerInfo:(void(^)(void))callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setRequestCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        
        NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
        
        [[session dataTaskWithURL:[NSURL URLWithString:kServerSettingUrl]
                completionHandler:^(NSData * _Nullable data,
                                    NSURLResponse * _Nullable response,
                                    NSError * _Nullable error) {
                    
                    NSError * e = NULL;
                    
                    if (error) {
                        NSLog(@"Error: %@", error);
                    } else {
                        NSDictionary * json = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
                        
                        if (e) {
                            NSLog(@"Error: %@", e);
                        } else {
                            [[NSUserDefaults standardUserDefaults] setObject:json forKey:@"default_server_configs"];
                            [self setManager:[[ASRServerConfigManager alloc] initWithJSON:json]];
                        }
                    }
                    
                    [self saveTime];
                    
                    if (callback) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            callback();
                        });
                    }
                }] resume];
    });
}


- (NSURLRequest *) urlRequest
{
    if (!_urlRequest) {
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kServerSettingUrl]
                                                                   cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                               timeoutInterval:kServerTimeout];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        _urlRequest = urlRequest;
    }
    
    return _urlRequest;
}

- (NSURLSession *) urlSession
{
    if (!_urlSession) {
        _urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    
    return _urlSession;
}

@end
