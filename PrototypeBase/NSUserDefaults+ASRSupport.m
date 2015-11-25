//
//  NSUserDefaults+ASRSupport.m
//  DemoV2
//
//  Created by Kenny Liou on 10/22/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "NSUserDefaults+ASRSupport.h"

@implementation NSUserDefaults (ASRSupport)

- (void) setServerConfig:(ASRServerConfig *)serverConfig withKey:(NSString *)key
{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:serverConfig];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}

- (ASRServerConfig *) getServerConfigWithKey:(NSString *)key
{
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
