//
//  BSREncode.h
//  DeepSpeechBaseKit
//
//  Created by Helin Wang on 11/6/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BSREncoder <NSObject>

- (NSData*)encode:(NSData*)data;
- (NSString*)format;
- (void)reset;

@end
