//
//  BSRTriggerWordEngine.h
//  DeepSpeechBaseKit
//
//  Created by Thuan Nguyen on 11/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "BSRStateHandler.h"

@protocol BSRTriggerWordEngine <BSRStateHandler>

@property (nonatomic, assign) BOOL triggerWordRecognized;

@end
