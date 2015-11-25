//
//  BSRServerConfig.h
//  DemoV2
//
//  Created by Kenny Liou on 10/21/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ASRServerType) {
    ASR_STREAM,
    ASR_BATCH,
};

@interface ASRServerConfig : NSObject <NSCoding>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *endpoint;
@property (strong, nonatomic) NSString *language;
@property (nonatomic) ASRServerType serverType;
@property (nonatomic) NSTimeInterval timeStamp;
@property (nonatomic) NSNumber *encodingSupport;

@end
