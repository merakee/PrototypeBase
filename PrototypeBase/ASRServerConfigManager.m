//
//  BSRServerConfigManager.m
//  DemoV2
//
//  Created by Kenny Liou on 10/21/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "ASRServerConfigManager.h"
#import "NSUserDefaults+ASRSupport.h"
#import "DemoHelper.h"
#import "BSRSpeechRecognizerSubclass.h"

static NSString * const kServerList =                   @"serverlist";
static NSString * const kServerOptions =                @"options";
static NSString * const kName =                         @"name";
static NSString * const kEndpoint =                     @"endpoint";
static NSString * const kEncodingSupport =              @"encodingSupport";
static NSString * const kType =                         @"type";
static NSString * const kLanguage =                     @"language";
static NSString * const kMaxConcurrency =               @"maxconcurrency";
static NSString * const kSampleRate =                   @"sampleRate";
static NSString * const kChunkSecond =                  @"chunkSecond";
static NSString * const kServerTimeout =                @"timeout";

static NSString * const kCurrentServerConfig =          @"currentServerConfig";
static NSString * const kCurrentServerOptions =         @"currentServerOptions";

static NSString * const kCurrentCNServerConfig =          @"currentCNServerConfig";
static NSString * const kCurrentUSServerConfig =          @"currentENServerConfig";


@interface ASRServerConfigManager()

@property (strong, nonatomic) NSArray * serverConfigList;
@property (nonatomic) NSTimeInterval timeStamp;

@end

@implementation ASRServerConfigManager

@synthesize currentServerConfig = _currentServerConfig;

+ (instancetype) getDefaultConfigs
{
    return [[ASRServerConfigManager alloc] initWithJSON:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"default_server_configs"]];
}

- (instancetype) initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        
        NSArray *servers = [json objectForKey:kServerList];
        
        [self setServerInfoListWithArray:servers];
        [self setTimeStamp:[[NSDate date] timeIntervalSince1970]];
    }
    
    return self;
}

- (NSTimeInterval) getTimeStamp
{
    return self.timeStamp;
}

- (void) setServerInfoListWithArray:(NSArray *) servers
{
    NSArray * jsonList = servers;
    NSMutableArray * serverList = [NSMutableArray array];
    
    if (!jsonList) {
        jsonList = @[
                      @{
                          @"name":@"Chinese: deepspeech.baidu.com",
                          @"endpoint":@"http://deepspeech.baidu.com/SpeechFrontEnd/Transcribe",
                          @"type": [NSNumber numberWithInt:0],
                          @"language":@"zh_CN"
                          },
                      @{
                          @"name":@"Chinese: MVP",
                          @"endpoint":@"http://104.254.65.131/SpeechFrontEnd/Transcribe",
                          @"type": [NSNumber numberWithInt:0],
                          @"language":@"zh_CN",
                          @"encodingSupport":[NSNumber numberWithInt:1]
                          },
                      @{
                          @"name":@"Chinese: us.deepspeech.baidu.com",
                          @"endpoint":@"http://us.deepspeech.baidu.com/SpeechFrontEnd/Transcribe",
                          @"type": [NSNumber numberWithInt:0],
                          @"language":@"zh_CN"
                          },
                      @{
                          @"name":@"Chinese: Amazon server",
                          @"endpoint":@"https://api.spchrsrch.com/v1/transcribe/chinese",
                          @"type": [NSNumber numberWithInt:1],
                          @"language":@"zh_CN"
                          },
                      @{
                          @"name":@"English: Amazon server",
                          @"endpoint":@"https://api.spchrsrch.com/v1/transcribe/english",
                          @"type": [NSNumber numberWithInt:1],
                          @"language":@"en_US"
                          },
                      @{
                          @"name":@"Chinese: for debug",
                          @"endpoint":@"http://172.19.51.0:8001/SpeechFrontEnd/Transcribe",
                          @"type": [NSNumber numberWithInt:0],
                          @"language":@"zh_CN"
                          }
                      ];
    }
    
    for (id obj in jsonList) {
        NSDictionary * dic = (NSDictionary *) obj;
        
        [serverList addObject:[self createServerInfoFromDic:dic]];
    }
    
    [self setServerConfigList:[NSArray arrayWithArray:serverList]];

    
}

- (ASRServerConfig *) createServerInfoFromDic:(NSDictionary *) dic
{
    ASRServerConfig * result = [[ASRServerConfig alloc] init];
    
    if (dic) {
        
        [result setName:[dic objectForKey:kName]];
        [result setEndpoint:[dic objectForKey:kEndpoint]];
        [result setLanguage:[dic objectForKey:kLanguage]];
        [result setTimeStamp:[[NSDate date] timeIntervalSince1970]];
        [result setEncodingSupport:[dic objectForKey:kEncodingSupport]];
        
        NSNumber * type = [dic objectForKey:kType];
        [result setServerType:type.intValue == 0 ? ASR_STREAM : ASR_BATCH];
    }
    
    return result;
}

- (int) getServerCount
{
    return (int)[self.serverConfigList count]; // fuck you Apple >:(
}

- (NSArray *) getServerConfigs
{
    return self.serverConfigList;
}

- (void)setCurrentServerConfig:(ASRServerConfig *)currentServerConfig {
    _currentServerConfig = currentServerConfig;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setServerConfig:currentServerConfig withKey:kCurrentServerConfig];
    [[DemoHelper sharedInstance] updateServerConfig:currentServerConfig];
}

- (ASRServerConfig *) currentServerConfig
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    ASRServerConfig * record = [ud getServerConfigWithKey:kCurrentServerConfig];
    
    if (record) {
        if (!_currentServerConfig) {
            _currentServerConfig = record;
        } else {
            if ([record timeStamp] > [_currentServerConfig timeStamp]) {
                _currentServerConfig = record;
            }
        }
        
    } else {
        // if we don't have server config in local db, initialize with default and fetch from server info
        
        _currentServerConfig = [[self getServerConfigs] objectAtIndex:0]; // use the first one
        
        // make sure we make a copy to local db
        [ud setServerConfig:_currentServerConfig withKey:kCurrentServerConfig];
    }
    
    [self.delegate serverConfigUpdated:_currentServerConfig];
    
    return _currentServerConfig;
}

- (ASRServerConfig *) currentServerConfigForLanguage:(NSString*)language
{
    ASRServerConfig *serverConfig = nil;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
 
    NSString *userPrefString = [self userPreferenceKeyForLanguage:language];
    serverConfig = [ud getServerConfigWithKey:userPrefString];
    
    if (!serverConfig) {
        for (ASRServerConfig *config in [self getServerConfigs]) {
            if ([config.language isEqualToString:language]) {
                serverConfig = config;
                break;
            }
        }
        
        // make sure we make a copy to local db
        [ud setServerConfig:serverConfig withKey:userPrefString];
    }
    return serverConfig;
}

- (void)setCurrentServerConfig:(ASRServerConfig *)currentServerConfig forLanguage:(NSString*)language {
    NSString *userPrefString = [self userPreferenceKeyForLanguage:language];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setServerConfig:currentServerConfig withKey:userPrefString];
}

- (NSString*)userPreferenceKeyForLanguage:(NSString*)language {
    NSString *userPrefString = nil;
    if ([language isEqualToString:@"zh_CN"]) {
        userPrefString = kCurrentCNServerConfig;
    } else if ([language isEqualToString:@"en_US"]) {
        userPrefString = kCurrentUSServerConfig;
    } else {
        NSAssert(NO, @"Sorry, don't support those languages");
    }
    return userPrefString;
}


@end
