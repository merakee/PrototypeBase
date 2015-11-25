//
//  BSRServerConfig.m
//  DemoV2
//
//  Created by Kenny Liou on 10/21/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "ASRServerConfig.h"

static NSString * const kServerName = @"servername";
static NSString * const kServer = @"server";
static NSString * const kEndpoint = @"endpoint";
static NSString * const kLanguage = @"language";
static NSString * const kServerType = @"type";
static NSString * const kTimeStamp = @"tiemStamp";
static NSString * const kEncodingSupport = @"encodingSupport";

@implementation ASRServerConfig

#pragma mark - NSCoding support
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    ASRServerConfig * config = [[ASRServerConfig alloc] init];
    
    [config setName:[aDecoder decodeObjectForKey:kServerName]];
    [config setEndpoint:[aDecoder decodeObjectForKey:kEndpoint]];
    [config setLanguage:[aDecoder decodeObjectForKey:kLanguage]];
    
    NSNumber * typeInt = [aDecoder decodeObjectForKey:kServerType];
    [config setServerType:(ASRServerType) typeInt.intValue];
    
    NSNumber * timeDouble = [aDecoder decodeObjectForKey:kTimeStamp];
    [config setTimeStamp:(NSTimeInterval)timeDouble.doubleValue];

    NSNumber * encodingSupport = [aDecoder decodeObjectForKey:kEncodingSupport];
    [config setEncodingSupport:encodingSupport];

    return config;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:kServerName];
    [encoder encodeObject:self.endpoint forKey:kEndpoint];
    [encoder encodeObject:self.language forKey:kLanguage];
    [encoder encodeObject:[NSNumber numberWithInt:self.serverType] forKey:kServerType];
    [encoder encodeObject:[NSNumber numberWithDouble:self.timeStamp] forKey:kTimeStamp];
    [encoder encodeObject:self.encodingSupport forKey:kEncodingSupport];
}

@end
