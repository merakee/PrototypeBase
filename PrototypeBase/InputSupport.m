//
//  InputSupport.m
//  DemoV2
//
//  Created by Kenny Liou on 10/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "InputSupport.h"

@import AVFoundation;

@implementation InputSupport

+ (BOOL) hasInputOption
{
    return [[[AVAudioSession sharedInstance] availableInputs] count] > 0;
}

+ (NSString *) inputName
{
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    AVAudioSessionRouteDescription * currentRoute = [audioSession currentRoute];
    AVAudioSessionPortDescription * currentInput = currentRoute.inputs[0];
    
    return [currentInput portName];
}

+ (UIAlertController *) createActionSheetController
{
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"Input Option" message:@"Select your input method" preferredStyle:UIAlertControllerStyleActionSheet];
    
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    AVAudioSessionRouteDescription * currentRoute = [audioSession currentRoute];
    AVAudioSessionPortDescription * currentInput = currentRoute.inputs[0];
    NSArray * inputRoutes = [audioSession availableInputs];
    
    for (int i = 0; i < [inputRoutes count]; i++) {
        
        AVAudioSessionPortDescription * desc = [inputRoutes objectAtIndex:i];
        
        BOOL selected = [[currentInput portName] isEqualToString:[desc portName]];
        [InputSupport addAction:controller withPort:[inputRoutes objectAtIndex:i] selected:selected];
    }
    
    [InputSupport addCancelAction:controller];
    
    return controller;
}

+ (void) addAction:(UIAlertController *) controller withPort:(AVAudioSessionPortDescription *) port selected:(BOOL)selected
{
    
    [controller addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@%@", selected ? @"✔️   " :@"   ", [port portName]]
                                    style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
                                      
                                      [[AVAudioSession sharedInstance] setPreferredInput:port error:NULL];
                                      [controller dismissViewControllerAnimated:YES completion:NULL];
    }]];
}

+ (void) addCancelAction:(UIAlertController *) controller
{
    [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:NULL];
    }]];
}

@end
