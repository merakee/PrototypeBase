//
//  AppUIManager.swift
//  TryingOutSwift
//
//  Created by Bijit Halder on 10/3/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

import UIKit
import PureLayout

class AppUIManager{
    
    // MARK: - singleton
    static let sharedManager = AppUIManager()
    private init() {
    }
    
    
    // MARK: - Layout methods
    func horizontallyCenterElement(view:UIView, inView:UIView){
        // Center
        inView.addConstraint(NSLayoutConstraint(item:view,
            attribute:.CenterX,
            relatedBy:.Equal,
            toItem:inView,
            attribute:.CenterX,
            multiplier:1.0,
            constant:0.0))
    }
    func verticallyCenterElement(view:UIView, inView:UIView){
        // Center
        inView.addConstraint(NSLayoutConstraint(item:view,
            attribute:.CenterY,
            relatedBy:.Equal,
            toItem:inView,
            attribute:.CenterY,
            multiplier:1.0,
            constant:0.0))
    }
    
    //+(NSUInteger) getSupportedOrentation{
    //    return UIInterfaceOrientationMaskPortrait |  UIInterfaceOrientationMaskPortraitUpsideDown;
    //}
    //
    //#pragma mark - Appwide settings
    //+(UIStatusBarStyle)getStatusBarStyle{
    //    return UIStatusBarStyleLightContent;
    //}
    
    
    //#pragma mark - view elements methods:  UIview
    //+ (void)setUIView:(UIView *)view{
    //    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    //    }
    //
    //    + (void)setUIView:(UIView *)view ofType:(AUCPriorityType)pType{
    //        // set view properties
    //        //view.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeGray];
    //        view.backgroundColor = [UIColor whiteColor];
    //
    //        // add gradient
    //        //[AppUIManager addColorGradient:view];
    //        }
    //
    //        + (void)addColorGradient:(NSArray *)colors toView:(UIView *)view{
    //            CAGradientLayer *gradient = [CAGradientLayer layer];
    //            gradient.frame = view.bounds;
    //            gradient.colors = colors;
    //
    //            //@[(id)[[AppUIManager getColorOfType:kAUCColorTypeBackground withBrightness:kAUCColorScaleNormal andSaturation:kAUCColorScaleLightest] CGColor],
    //            // (id)[[AppUIManager getColorOfType:kAUCColorTypePrimary withBrightness:kAUCColorScaleLightest
    //            //                   andSaturation:kAUCColorScaleDarkest] CGColor],
    //            //                   (id)[[AppUIManager getColorOfType:kAUCColorTypeBackground withBrightness:kAUCColorScaleLight
    //            //                                       andSaturation:kAUCColorScaleDark] CGColor],
    //            // (id)[[AppUIManager getColorOfType:kAUCColorTypeBackground withBrightness:kAUCColorScaleNormal andSaturation:kAUCColorScaleLightest] CGColor]];
    //            //[view.layer insertSublayer:gradient atIndex:1];
    //            [view.layer addSublayer:gradient];
    //}
    //
    //
    ////+ (void)addColorGradient:(UIView *)view{
    ////    CAGradientLayer *gradient = [CAGradientLayer layer];
    ////    gradient.frame = view.bounds;
    ////    gradient.colors = @[(id)[[AppUIManager getColorOfType:kAUCColorTypeBackground withBrightness:kAUCColorScaleNormal andSaturation:kAUCColorScaleLightest] CGColor],
    ////                        // (id)[[AppUIManager getColorOfType:kAUCColorTypePrimary withBrightness:kAUCColorScaleLightest
    ////                        //                   andSaturation:kAUCColorScaleDarkest] CGColor],
    ////                        (id)[[AppUIManager getColorOfType:kAUCColorTypeBackground withBrightness:kAUCColorScaleLight
    ////                                            andSaturation:kAUCColorScaleDark] CGColor],
    ////                        (id)[[AppUIManager getColorOfType:kAUCColorTypeBackground withBrightness:kAUCColorScaleNormal andSaturation:kAUCColorScaleLightest] CGColor]];
    ////    //[view.layer insertSublayer:gradient atIndex:1];
    ////    [view.layer addSublayer:gradient];
    ////}
    //
    //#pragma mark - view elements methods:  UIImageView
    //+ (void)setImageView:(UIImageView *)iv{
    //    //iv.backgroundColor  =[AppUIManager getColorOfType:kAUCColorTypeGray withBrightness:kAUCColorScaleDark];
    //
    //    // rounder cover
    //    //[AppUIManager setRoundedCornerToImageView:iv];
    //    // for auto layout
    //    [iv setTranslatesAutoresizingMaskIntoConstraints:NO];
    //}
    //
    //
    //#pragma mark - view elements methods:  UIButton
    
    func getButtonWithTitle(title: String, buttonColor: UIColor, textColor: UIColor) -> UIButton {
        let button = UIButton.newAutoLayoutView()
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(textColor, forState: .Normal)
        button.backgroundColor = buttonColor;
        // button.setTitleColor(.grayColor(), forState: .Highlighted)
        return button
    }
    
    //+ (void)setUIButton:(UIButton *)button{
    //    [AppUIManager setUIButton:button  ofType:kAUCPriorityTypePrimary];
    //    }
    //    + (UIButton *)getTransparentUIButton{
    //        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    //
    //        // colors and fonts
    //        button.backgroundColor = [UIColor clearColor];
    //
    //        // Uncomment to see border
    //        //[AppUIManager setBorder:button withColor:[UIColor redColor]];
    //
    //        // for auto layout
    //        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    //
    //        return button;
    //        }
    //        + (UIButton *)getTransparentUIButtonWithTitle:(NSString *)title color:(AUCColorType)colorType font:(NSString *)fontFamily size:(CGFloat)fontSize{
    //            UIButton *button  = [AppUIManager getTransparentUIButton];
    //            [button setTitle:title forState:UIControlStateNormal];
    //            [button setTitleColor:[AppUIManager getColorOfType:colorType] forState:UIControlStateNormal];
    //            [button.titleLabel setFont:[UIFont fontWithName:fontFamily  size:fontSize]];
    //            return button;
    //            }
    //
    //            + (void)setUIButton:(UIButton *)button ofType:(AUCPriorityType)pType{
    //                // colors and fonts
    //                //button.backgroundColor = [UIColor clearColor];
    //
    //                // colors and fonts
    //                //[AppUIManager setClearButton:button ofType:pType];
    //                //[AppUIManager setSolidButton:button ofType:pType];
    //
    //                // set button properties
    //                // titleLabel  property
    //                //titleForState:
    //                // – setTitle:forState:
    //                //– attributedTitleForState:
    //                //– setAttributedTitle:forState:
    //
    //                //[button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeTextPrimary] forState:UIControlStateNormal];
    //                //[button setBackgroundColor:[UIColor whiteColor]];
    //
    //                // – setTitleColor:forState:
    //                // – titleShadowColorForState:
    //                // – setTitleShadowColor:forState:
    //                // reversesTitleShadowWhenHighlighted  property
    //
    //                // rounded corner
    //                [AppUIManager setRoundedCorner:button];
    //
    //                // set font
    //                [AppUIManager setFontForButton:button ofType:pType];
    //
    //                // for auto layout
    //                [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    //
    //                }
    //
    //                //+ (void)setSolidButton:(UIButton *)button ofType:(AUCPriorityType)pType{
    //                //    // colors and fonts
    //                //    switch (pType) {
    //                //        case kAUCPriorityTypeSecondary:
    //                //            button.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeSecondary];
    //                //            [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight] forState:UIControlStateNormal];
    //                //            break;
    //                //        case kAUCPriorityTypeTertiary:
    //                //            button.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTertiary];
    //                //            [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight] forState:UIControlStateNormal];
    //                //            break;
    //                //        default:
    //                //            button.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorTextTeal];
    //                //            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //                //            break;
    //                //    }
    //                //
    //                //}
    //                + (void)setClearButton:(UIButton *)button ofType:(AUCPriorityType)pType{
    //                    // colors and fonts
    //                    button.backgroundColor = [UIColor clearColor];
    //                    switch (pType) {
    //                    case kAUCPriorityTypeSecondary:
    //                        [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeSecondary] forState:UIControlStateNormal];
    //                        // border
    //                        [AppUIManager setBorder:button withColor:[AppUIManager getColorOfType:kAUCColorTypeSecondary]];
    //                        break;
    //                    case kAUCPriorityTypeTertiary:
    //                        [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeTertiary] forState:UIControlStateNormal];
    //                        // border
    //                        [AppUIManager setBorder:button withColor:[AppUIManager getColorOfType:kAUCColorTypeTertiary]];
    //                        break;
    //                    default:
    //                        [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypePrimary] forState:UIControlStateNormal];
    //                        // border
    //                        [AppUIManager setBorder:button withColor:[AppUIManager getColorOfType:kAUCColorTypePrimary]];
    //                        break;
    //                    }
    //
    //                    }
    //
    //                    + (UIButton *)setButtonWithTitle:(NSString *)text ofType:(AUCPriorityType)pType{
    //                        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    //                        // set app defaults
    //                        [AppUIManager setUIButton:button ofType:pType];
    //                        [button setTitle:text forState:UIControlStateNormal];
    //
    //                        return button;
    //                        }
    //                        + (UIButton *)setButtonWithTitle:(NSString *)text andColor:(UIColor *)bColor{
    //                            UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    //                            // set app defaults
    //                            [AppUIManager setUIButton:button];
    //
    //                            // cumtom
    //                            [button setTitleColor:bColor forState:UIControlStateNormal];
    //                            [AppUIManager setBorder:button withColor:bColor];
    //                            [button setTitle:text forState:UIControlStateNormal];
    //
    //                            return button;
    //                            }
    //
    //                            + (void)setFontForButton:(UIButton *)button  ofType:(AUCPriorityType)pType{
    //                                switch (pType) {
    //                                case kAUCPriorityTypeSecondary:
    //                                    [button.titleLabel setFont:[UIFont fontWithName:kAUCFontFamilySecondary  size:kAUCFontSizeSecondary]];
    //                                    break;
    //                                    //        case kAUCPriorityTypeTertiary:
    //                                    //            [button.titleLabel setFont:[UIFont fontWithName:kAUCFontFamilyTertiary  size:kAUCFontSizeTertiary]];
    //                                    //            break;
    //                                default:
    //                                    [button.titleLabel setFont:[UIFont fontWithName:kAUCFontFamilyPrimary  size:kAUCFontSizePrimary]];
    //                                    break;
    //                                }
    //}
    
    //#pragma mark - view elements methods:  UISegmentedControl
    //+ (void)setUISegmentedControl:(UISegmentedControl *)sControl{
    //
    //    // for auto layout
    //    [sControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    //}
    //#pragma mark - view elements methods:  UITextView
    //+ (void)setTextView:(UITextView *)textView{
    //    [AppUIManager setTextView:textView ofType:kAUCPriorityTypePrimary];
    //    }
    //
    //    + (void)setTextView:(UITextView *)textView ofType:(AUCPriorityType)pType{
    //        // set textview properties
    //        // colors and fonts
    //        switch (pType) {
    //        case kAUCPriorityTypeSecondary:
    //            textView.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeSecondary];
    //            textView.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeSecondary];
    //            textView.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextSecondary];
    //            break;
    //            //        case kAUCPriorityTypeTertiary:
    //            //            textView.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTertiary];
    //            //            textView.font = [UIFont fontWithName:kAUCFontFamilyTertiary size:kAUCFontSizeTertiary];
    //            //            textView.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextTertiary];
    //            //            break;
    //
    //        default:
    //            textView.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypePrimary];
    //            textView.font = [UIFont fontWithName:kAUCFontFamilyPrimary size:kAUCFontSizePrimary];
    //            textView.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimary];
    //            break;
    //        }
    //
    //        textView.backgroundColor = [UIColor whiteColor];
    //
    //        // other properties
    //
    //        // textView.text=@"";
    //        //textView.attributedText =
    //        //
    //        //
    //
    //        // others
    //        //textView.editable = NO;
    //        //textView.selectable = YES;
    //        //textView.allowsEditingTextAttributes = NO;
    //        //textView.dataDetectorTypes = UIDataDetectorTypeAll ;
    //        textView.textAlignment = NSTextAlignmentCenter;
    //        //textView.typingAttributes =
    //        // textView.linkTextAttributes =
    //        //textView.textContainerInset =
    //        //[textView sizeToFit];
    //
    //        // text shadow: use layer property (UIView)
    //        //textView.layer.shadowColor = [HEXCOLOR (kCRDShadowWhiteColor) CGColor];
    //        //textView.layer.shadowColor = [HEXCOLOR (kCRDTextDropShadowColor) CGColor];
    //        // textView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    //        // textView.layer.shadowOpacity = 0.6f;
    //        // textView.layer.shadowRadius = 0.0f;
    //
    //        // set up key board
    //        //textView.keyboardType = UIKeyboardTypeAlphabet;
    //        //textView.returnKeyType = UIReturnKeyDefault;
    //
    //        // rounded corner
    //        //[AppUIManager setRoundedCorner:textView];
    //
    //        // for auto layout
    //        [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    //        }
    //        + (void)verticallyAlignTextView:(UITextView *)textView{
    //            CGSize size =[AppUIManager getSizeForText:textView.text  sizeWithFont:textView.font constrainedToSize:textView.frame.size];
    //            CGRect  nFrame =textView.frame;
    //            nFrame.size.height = size.height+30;
    //            nFrame.origin.y = (textView.superview.frame.size.height-nFrame.size.height)/2.0;
    //            textView.frame = nFrame;
    //}
    //
    //#pragma mark - view elements methods: UITextFeild
    //+ (void)setTextField:(UITextField *)textField placeholder:(NSString *)phtext{
    //    // cutom settings
    //    // set textField properties
    //    textField.backgroundColor = [UIColor clearColor];
    //    textField.attributedPlaceholder = [[NSAttributedString alloc]
    //        initWithString:phtext
    //        attributes:@{NSForegroundColorAttributeName:[AppUIManager getColorOfType:kAUCColorTypeTextTertiary],
    //            NSFontAttributeName:[UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeTextField]}];
    //    textField.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeTextField];
    //    textField.textColor =[AppUIManager getColorOfType:kAUCColorTypeTextPrimary];
    //    textField.textAlignment = NSTextAlignmentLeft;
    //
    //    // set border
    //    [AppUIManager setBottomBorder:textField withColor:[AppUIManager getColorOfType:kAUCColorTypeTertiary]];
    //
    //    // for auto layout
    //    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    }
    //
    //    + (void)setTextField:(UITextField *)textField ofType:(AUCPriorityType)pType{
    //        // set textField properties
    //        // colors and fonts
    //        switch (pType) {
    //        case kAUCPriorityTypeSecondary:
    //            textField.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeSecondary];
    //            textField.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeSecondary];
    //            textField.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextSecondary];
    //            // add border
    //            [AppUIManager setBorder:textField withColor:[AppUIManager getColorOfType:kAUCColorTypeSecondary]];
    //            break;
    //            //        case kAUCPriorityTypeTertiary:
    //            //            textField.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTertiary];
    //            //            textField.font = [UIFont fontWithName:kAUCFontFamilyTertiary size:kAUCFontSizeTertiary];
    //            //            textField.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextTertiary];
    //            //            // add border
    //            //            [AppUIManager setBorder:textField withColor:[AppUIManager getColorOfType:kAUCColorTypeTertiary]];
    //            //            break;
    //        default:
    //            textField.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypePrimary];
    //            textField.font = [UIFont fontWithName:kAUCFontFamilyPrimary size:kAUCFontSizePrimary];
    //            textField.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimary];
    //            // add border
    //            [AppUIManager setBottomBorder:textField withColor:[AppUIManager getColorOfType:kAUCColorTypePrimary]];
    //            break;
    //        }
    //
    //        textField.backgroundColor = [UIColor clearColor];
    //        // palce holder text color
    //        //textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"place holder" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //        textField.textAlignment = NSTextAlignmentCenter;
    //        // others
    //        //textField.borderStyle  property
    //        //background  property
    //        // disabledBackground  property
    //
    //        // rounded corner
    //        //[AppUIManager setRoundedCorner:textField];
    //
    //
    //}
    //
    //#pragma mark - view elements methods:  UILabel
    ////+ (void)setUILabel:(UILabel *)label{
    ////    [AppUIManager setUILabel:label ofType:kAUCPriorityTypePrimary];
    ////}
    //
    //+ (UILabel *)getUILabelWithText:(NSString *)text font:(NSString *)fontFamily ofSize:(CGFloat)fontSize color:(AUCColorType)color{
    //    UILabel *label =[[UILabel alloc] init];
    //    label.text = text;
    //    label.backgroundColor = [UIColor clearColor];
    //    label.font = [UIFont fontWithName:fontFamily size:fontSize];
    //    label.textColor = [AppUIManager getColorOfType:color];
    //
    //
    //    // palce holder text color
    //    //label.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"place holder" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //    label.textAlignment = NSTextAlignmentCenter;
    //    // others
    //    //label.borderStyle  property
    //    //background  property
    //    // disabledBackground  property
    //
    //    // rounded corner
    //    //[AppUIManager setRoundedCorner:label];
    //
    //    // for auto layout
    //    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    return label;
    //}
    ////
    ////+ (void)setUILabel:(UILabel *)label ofType:(AUCPriorityType)pType{
    ////    // set label properties
    ////    // colors and fonts
    ////    switch (pType) {
    ////        case kAUCPriorityTypeSecondary:
    ////            label.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeSecondary];
    ////            label.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeSecondary];
    ////            label.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight];
    ////            // add border
    ////            //[AppUIManager setBorder:label withColor:[AppUIManager getColorOfType:kAUCColorTypeSecondary]];
    ////            break;
    ////        case kAUCPriorityTypeTertiary:
    ////            label.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTertiary];
    ////            label.font = [UIFont fontWithName:kAUCFontFamilyTertiary size:kAUCFontSizeTertiary];
    ////            label.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight];
    ////            // add border
    ////            //[AppUIManager setBorder:label withColor:[AppUIManager getColorOfType:kAUCColorTypeTertiary]];
    ////            break;
    ////        default:
    ////            label.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypePrimary];
    ////            label.font = [UIFont fontWithName:kAUCFontFamilyPrimary size:kAUCFontSizePrimary];
    ////            label.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight];
    ////            // add border
    ////            //[AppUIManager setBorder:label withColor:[AppUIManager getColorOfType:kAUCColorTypePrimary]];
    ////            break;
    ////    }
    ////
    ////    label.backgroundColor = [UIColor clearColor];
    ////    // palce holder text color
    ////    //label.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"place holder" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    ////    label.textAlignment = NSTextAlignmentCenter;
    ////    // others
    ////    //label.borderStyle  property
    ////    //background  property
    ////    // disabledBackground  property
    ////
    ////    // rounded corner
    ////    //[AppUIManager setRoundedCorner:label];
    ////
    ////    // for auto layout
    ////    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    ////}
    //#pragma mark - view elements methods:  Navbar
    //+ (void)setNavbar:(UINavigationBar *)navbar{
    //    //backIndicatorImage  property
    //    //backIndicatorTransitionMaskImage  property
    //    //barStyle  property
    //    //barTintColor  property
    //    //shadowImage  property
    //    //tintColor  property
    //    //navbar.tintColor  =  [AppUIManager getColorOfType:kAUCColorTypeTint];
    //    //translucent  property
    //    //navbar.translucent  =  YES;
    //    //– backgroundImageForBarMetrics:
    //    //– setBackgroundImage:forBarMetrics:
    //    //– backgroundImageForBarPosition:barMetrics:
    //    //– setBackgroundImage:forBarPosition:barMetrics:
    //    //– titleVerticalPositionAdjustmentForBarMetrics:
    //    //– setTitleVerticalPositionAdjustment:forBarMetrics:
    //    //titleTextAttributes  property
    //
    //}
    //
    //
    //#pragma mark - view elements methods:  Tabbar
    //+ (void)setTabbar:(UITabBar *)tabbar{
    //    // set properties
    //    //tabbar.barStyle  =  UIBarStyleDefault;
    //    //tabbar.barTintColor  =  [AppUIManager getColorOfType:kAUCColorTypeTint];
    //    //tabbar.itemPositioning  =  ;
    //    //tabbar.itemSpacing  =  ;
    //    //tabbar.itemWidth  =  ;
    //    //tabbar.tintColor  =  [AppUIManager getColorOfType:kAUCColorTypeTintSelected];
    //
    //    //tabbar.selectedImageTintColor  =  [AppUIManager getColorOfType:kAUCColorTypeTertiary];
    //    tabbar.translucent  =  NO;
    //    //tabbar.backgroundImage  =  ;
    //    //tabbar.shadowImage  =  ;
    //    //tabbar.selectionIndicatorImage  =  ;
    //
    //}
    //
    //
    //
    //#pragma mark - view elements methods:  Toolbar
    //+ (void)setToolbar:(UIToolbar *)toolbar{
    //
    //}
    //
    //
    //#pragma mark - view elements methods:  Table view
    //+ (void)setTableView:(UITableView *)tableView{
    //    [AppUIManager setTableView:tableView ofType:kAUCPriorityTypePrimary];
    //    }
    //
    //    + (void)setTableCell:(UITableViewCell *)tableViewCell{
    //        [AppUIManager setTableCell:tableViewCell ofType:kAUCPriorityTypePrimary];
    //        }
    //
    //        + (void)setTableView:(UITableView *)tableView ofType:(AUCPriorityType)pType{
    //            // clear backgroud
    //            tableView.backgroundView = nil;
    //            //tableView.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeBackground];
    //            //[AppUIManager setUIView:tableView.backgroundView  ofType:kAUCPriorityTypePrimary];
    //
    //            }
    //
    //            + (void)setTableCell:(UITableViewCell *)tableViewCell ofType:(AUCPriorityType)pType{
    //
    //}
    //
    //#pragma mark - view elements methods:  Activity Indicator
    //+ (void)addActivityIndicator:(UIActivityIndicatorView *)activityIndicator toView:(UIView *)view{
    //    [activityIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    activityIndicator.hidesWhenStopped=YES;
    //    activityIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyleGray;
    //    [view addSubview:activityIndicator];
    //
    //    // layout: in the center
    //    [AppUIManager verticallyCenterElement:activityIndicator inView:view];
    //    [AppUIManager horizontallyCenterElement:activityIndicator inView:view];
    //    }
    //
    //    + (void)addCustomActivityIndicator:(CustomActivityIndicator *)activityIndicator toView:(UIView *)view{
    //        [activityIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    //        activityIndicator.hidesWhenStopped=YES;
    //        activityIndicator.activityIndicatorStyle  = kAUCCustomActivityIndicatorStyleGray;
    //        [view addSubview:activityIndicator];
    //
    //        // size
    //        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(activityIndicator);
    //        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[activityIndicator(50)]"
    //            options:0 metrics:nil views:viewsDictionary]];
    //        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[activityIndicator(50)]"
    //            options:0 metrics:nil views:viewsDictionary]];
    //
    //        // layout: in the center
    //        [AppUIManager verticallyCenterElement:activityIndicator inView:view];
    //        [AppUIManager horizontallyCenterElement:activityIndicator inView:view];
    //}
    //
    //
    //#pragma mark - Utility methods
    //+ (void)setRoundedCorner:(id)view{
    //    // rounded corner
    //    ((UIView *)view).layer.cornerRadius = kAUCRectCornerRadius;
    //    }
    //    + (void)setRoundedCornerToImageView:(UIImageView *)iv{
    //        // rounded corner
    //        // Get the Layer of any view
    //        CALayer *caLayer = [iv layer];
    //        [caLayer setMasksToBounds:YES];
    //        [caLayer setCornerRadius:kAUCRectCornerRadius];
    //        }
    //        + (void)setCircularCropToImageView:(UIImageView *)iv{
    //            // create shape layer for circle we'll draw on top of image (the boundary of the circle)
    //            CAShapeLayer *circleLayer = [CAShapeLayer layer];
    //            circleLayer.lineWidth = 1.0;
    //            circleLayer.fillColor = [[UIColor whiteColor] CGColor];
    //            circleLayer.strokeColor = [[UIColor whiteColor] CGColor];
    //
    //            iv.layer.mask=circleLayer;
    //
    //            [CommonUtility  printPoint:iv.center];
    //            //NSLog(@"%f",fminf(iv.frame.size.height,iv.frame.size.width)/2.0-circleLayer.lineWidth);
    //            // create circle path
    //            UIBezierPath *path = [UIBezierPath bezierPath];
    //            [path addArcWithCenter:iv.center
    //                radius:fminf(iv.frame.size.height,iv.frame.size.width)/2.0-circleLayer.lineWidth
    //                startAngle:0.0
    //                endAngle:M_PI * 2.0
    //                clockwise:YES];
    //            circleLayer.path = [path CGPath];
    //
    //
    //            }
    //            + (void)setBorder:(id)view withColor:(UIColor *)color{
    //                ((UIView *)view).layer.borderWidth = kAUCRectBorderWidth;
    //                if(color==nil){
    //                    ((UIView *)view).layer.borderColor = [UIColor whiteColor].CGColor;
    //                }
    //                else{
    //                    ((UIView *)view).layer.borderColor = color.CGColor;
    //                }
    //                }
    //
    //                + (void)setBottomBorder:(id)view withColor:(UIColor *)color{
    //                    //    CALayer *bottomBorder = [CALayer layer];
    //                    //    bottomBorder.frame = CGRectMake(0.0f, 0.0f, ((UIView *)view).frame.size.width, 20.0f);
    //                    //    bottomBorder.backgroundColor = [UIColor redColor].CGColor;//color.CGColor;
    //                    //    [((UIView *)view).layer addSublayer:bottomBorder];
    //
    //                    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0.0, ((UIView *)view).frame.size.width-2.0,((UIView *)view).frame.size.width, 2.0)];
    //                    //topView.opaque = YES;
    //                    topView.backgroundColor = color;
    //                    topView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    //                    [(UIView *)view addSubview:topView];
    //
    //                    //    ((UIView *)view).layer.borderWidth = 2;
    //                    //    if(color==nil){
    //                    //        ((UIView *)view).layer.borderColor = [UIColor whiteColor].CGColor;
    //                    //    }
    //                    //    else{
    //                    //        ((UIView *)view).layer.borderColor = color.CGColor;
    //                    //    }
    //                    }
    //
    //
    //                    + (CGSize)getSizeForText:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    //                        CGRect frame = [text boundingRectWithSize:size
    //                            options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
    //                            attributes:@{NSFontAttributeName:font}
    //                        context:nil];
    //                        return frame.size;
    //}
    //
    //
    //#pragma mark - view elements methods:  App logo
    //+ (UIImageView *)getAppLogoView{
    //    UIImageView *iv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:kAUCAppLogoImage]];
    //    // defautl setting
    //    [AppUIManager setImageView:iv];
    //    return iv;
    //    }
    //
    //    + (UIImageView *)getAppLogoViewForNavTitle{
    //        UIImageView *iv =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,40,40)];
    //        iv.contentMode = UIViewContentModeScaleAspectFit;
    //        iv.image = [UIImage imageNamed:kAUCAppLogoImage];
    //        return iv;
    //}
    //
    //
    //#pragma mark  - layout methods
    //+ (void)horizontallyCenterElement:(UIView *)view inView:(UIView *)sview{
    //    // Center
    //    [sview addConstraint:[NSLayoutConstraint constraintWithItem:view
    //        attribute:NSLayoutAttributeCenterX
    //        relatedBy:NSLayoutRelationEqual
    //        toItem:sview
    //        attribute:NSLayoutAttributeCenterX
    //        multiplier:1.0
    //        constant:0.0]];
    //    }
    //    + (void)verticallyCenterElement:(UIView *)view inView:(UIView *)sview{
    //        // Center
    //        [sview addConstraint:[NSLayoutConstraint constraintWithItem:view
    //            attribute:NSLayoutAttributeCenterY
    //            relatedBy:NSLayoutRelationEqual
    //            toItem:sview
    //            attribute:NSLayoutAttributeCenterY
    //            multiplier:1.0
    //            constant:0.0]];
    //}
    //
    //#pragma mark - Timing methods
    //+(void)dispatchBlock:(void (^)())action afterDelay:(double)delayInSeconds {
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        if (action != nil){
    //            action();
    //        }
    //        });
    //}
    
}

