//
//  InputSupport.h
//  DemoV2
//
//  Created by Kenny Liou on 10/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputSupport : NSObject

+ (BOOL) hasInputOption;
+ (NSString *) inputName;
+ (UIAlertController *) createActionSheetController;

@end
