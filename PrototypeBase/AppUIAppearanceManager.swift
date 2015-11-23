//
//  AppUIAppearanceManager.swift
//  PrototypeBase
//
//  Created by Bijit on 11/16/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit

class AppUIAppearanceManager: NSObject {
    
    class func setAppAppearance() {
        AppUIAppearanceManager.setUIActivityIndicatorView()
        AppUIAppearanceManager.setUIBarButtonItem()
        AppUIAppearanceManager.setUIButton()
        AppUIAppearanceManager.setUINavigationBar()
        AppUIAppearanceManager.setUIPageControl()
        AppUIAppearanceManager.setUIProgressView()
        AppUIAppearanceManager.setUIRefreshControl()
        AppUIAppearanceManager.setUISearchBar()
        AppUIAppearanceManager.setUISegmentedControl()
        AppUIAppearanceManager.setUISlider()
        AppUIAppearanceManager.setUIStepper()
        AppUIAppearanceManager.setUISwitch()
        AppUIAppearanceManager.setUITabBar()
        AppUIAppearanceManager.setUITableView()
        AppUIAppearanceManager.setUIToolbar()
        AppUIAppearanceManager.setUIView()
    }
    
    // Usage: Two Methods --------------
    // [[UINavigationBar appearance] setBarTintColor:myNavBarBackgroundColor];
    //[[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackgroundImage:myNavBarButtonBackgroundImage forState:state barMetrics:metrics];
    //[[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], [UIPopoverController class], nil] setBackgroundImage:myPopoverNavBarButtonBackgroundImage forState:state barMetrics:metrics];
    //[[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setBackgroundImage:myToolbarButtonBackgroundImage forState:state barMetrics:metrics];
    //[[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], [UIPopoverController class], nil] setBackgroundImage:myPopoverToolbarButtonBackgroundImage forState:state barMetrics:metrics];
    
    //------------------
    // To get a list of proprties that conform to UIAppearance Protocol Run this
    // $ cd /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS*.sdk/System/Library/Frameworks/UIKit.framework/Headers
    // $ grep -H UI_APPEARANCE_SELECTOR ./* | sed 's/ __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0) UI_APPEARANCE_SELECTOR;//'
    // To get a file: grep -H UI_APPEARANCE_SELECTOR ./* | sed 's/ __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0) UI_APPEARANCE_SELECTOR;//' >> ~/Desktop/UIAppearance_List.txt
    
    /*
    Here is the list obtained on 25 Feb 2014
    */
    // Rules for cutom view properties
    // UIAppearance.h: To participate in the appearance proxy API, tag your appearance property selectors in your header with UI_APPEARANCE_SELECTOR.
    // UIAppearance.h:#define UI_APPEARANCE_SELECTOR
    
    class func setUIActivityIndicatorView() {
        // UIActivityIndicatorView.h:@property (readwrite, nonatomic, retain) UIColor *color NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
    }
    
    class func setUIBarButtonItem() {
        // UIBarButtonItem.h:- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (UIImage *)backgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (UIImage *)backgroundImageForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (void)setBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (CGFloat)backgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (void)setTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (UIOffset)titlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (void)setBackButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (UIImage *)backButtonBackgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (void)setBackButtonTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (UIOffset)backButtonTitlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (void)setBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarButtonItem.h:- (CGFloat)backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIBarItem.h:- (void)setTitleTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // set color of unselected text to white
        //[[UIBarItem appearanceWhenContainedIn:[UINavigationBar class], nil]
        // setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppUIManager getColorOfType:kAUCColorTypeTintUnselected], NSForegroundColorAttributeName, nil]  forState:UIControlStateNormal];
        
        // set color of unselected text to white
        //[[UIBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppUIManager getColorOfType:kAUCColorTypeTintSelected], NSForegroundColorAttributeName, nil]  forState:UIControlStateSelected];
        
        // UIBarItem.h:- (NSDictionary *)titleTextAttributesForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
    }

    class func setUILabel() {
        UILabel.appearance().font = AppUIManager.sharedManager.appFont(20.0)
    }
    
    class func setUIButton() {
        // UIButton
        // UIButton.h:@property(nonatomic)          UIEdgeInsets contentEdgeInsets UI_APPEARANCE_SELECTOR; // default is UIEdgeInsetsZero
        // UIButton.h:- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state UI_APPEARANCE_SELECTOR; // default if nil. use opaque white
        // UIButton.h:- (void)setTitleShadowColor:(UIColor *)color forState:(UIControlState)state UI_APPEARANCE_SELECTOR; // default is nil. use 50% black
        // UIButton.h:- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state UI_APPEARANCE_SELECTOR; // default is nil
    }
    class func setUINavigationBar() {
        // UINavigationBar.h:@property(nonatomic,retain) UIColor *barTintColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // default is nil
        //[[UINavigationBar appearance] setBarTintColor:[AppUIManager getColorOfType:kAUCColorTypeTint]];
        
        //[[UINavigationBar appearance] setTintColor:[AppUIManager getColorOfType:kAUCColorTypeTintUnselected]];
        
        // UINavigationBar.h:- (void)setBackgroundImage:(UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
        // UINavigationBar.h:- (UIImage *)backgroundImageForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
        // UINavigationBar.h:- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UINavigationBar.h:- (UIImage *)backgroundImageForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UINavigationBar.h:@property(nonatomic,retain) UIImage *shadowImage NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UINavigationBar.h:@property(nonatomic,copy) NSDictionary *titleTextAttributes NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        
        // set color of unselected text to white
       // [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppUIManager getColorOfType:kAUCColorTypeTintUnselected], NSForegroundColorAttributeName, nil]];
        
        // UINavigationBar.h:- (void)setTitleVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UINavigationBar.h:- (CGFloat)titleVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UINavigationBar.h:@property(nonatomic,retain) UIImage *backIndicatorImage NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
        // UINavigationBar.h:@property(nonatomic,retain) UIImage *backIndicatorTransitionMaskImage NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
    }
    class func setUIPageControl() {
        // UIPageControl.h:@property(nonatomic,retain) UIColor *pageIndicatorTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIPageControl.h:@property(nonatomic,retain) UIColor *currentPageIndicatorTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
    }
    class func setUIProgressView() {
        // UIProgressView.h:@property(nonatomic, retain) UIColor* progressTintColor     NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIProgressView.h:@property(nonatomic, retain) UIColor* trackTintColor     NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIProgressView.h:@property(nonatomic, retain) UIImage* progressImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIProgressView.h:@property(nonatomic, retain) UIImage* trackImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
    }
    class func setUIRefreshControl() {
        // UIRefreshControl.h:@property (nonatomic, retain) NSAttributedString *attributedTitle UI_APPEARANCE_SELECTOR;
    }
    class func setUISearchBar() {
        // UISearchBar.h:@property(nonatomic,retain) UIColor *barTintColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // default is nil
        // UISearchBar.h:@property(nonatomic,retain) UIImage *backgroundImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:@property(nonatomic,retain) UIImage *scopeBarBackgroundImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (void)setBackgroundImage:(UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // Use UIBarMetricsDefaultPrompt to set a separate backgroundImage for a search bar with a prompt
        // UISearchBar.h:- (UIImage *)backgroundImageForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (void)setSearchFieldBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (UIImage *)searchFieldBackgroundImageForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (void)setImage:(UIImage *)iconImage forSearchBarIcon:(UISearchBarIcon)icon state:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (UIImage *)imageForSearchBarIcon:(UISearchBarIcon)icon state:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (void)setScopeBarButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (UIImage *)scopeBarButtonBackgroundImageForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (void)setScopeBarButtonDividerImage:(UIImage *)dividerImage forLeftSegmentState:(UIControlState)leftState rightSegmentState:(UIControlState)rightState NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (UIImage *)scopeBarButtonDividerImageForLeftSegmentState:(UIControlState)leftState rightSegmentState:(UIControlState)rightState NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (void)setScopeBarButtonTitleTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (NSDictionary *)scopeBarButtonTitleTextAttributesForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:@property(nonatomic) UIOffset searchFieldBackgroundPositionAdjustment NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:@property(nonatomic) UIOffset searchTextPositionAdjustment NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (void)setPositionAdjustment:(UIOffset)adjustment forSearchBarIcon:(UISearchBarIcon)icon NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISearchBar.h:- (UIOffset)positionAdjustmentForSearchBarIcon:(UISearchBarIcon)icon NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
    }
    
    class func setUISegmentedControl() {
        // UISegmentedControl.h:- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISegmentedControl.h:- (UIImage *)backgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISegmentedControl.h:- (void)setDividerImage:(UIImage *)dividerImage forLeftSegmentState:(UIControlState)leftState rightSegmentState:(UIControlState)rightState barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISegmentedControl.h:- (UIImage *)dividerImageForLeftSegmentState:(UIControlState)leftState rightSegmentState:(UIControlState)rightState barMetrics:(UIBarMetrics)barMetrics  NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISegmentedControl.h:- (void)setTitleTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISegmentedControl.h:- (NSDictionary *)titleTextAttributesForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISegmentedControl.h:- (void)setContentPositionAdjustment:(UIOffset)adjustment forSegmentType:(UISegmentedControlSegment)leftCenterRightOrAlone barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISegmentedControl.h:- (UIOffset)contentPositionAdjustmentForSegmentType:(UISegmentedControlSegment)leftCenterRightOrAlone barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
    }
    class func setUISlider() {
        // UISlider.h:@property(nonatomic,retain) UIColor *minimumTrackTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISlider.h:@property(nonatomic,retain) UIColor *maximumTrackTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISlider.h:@property(nonatomic,retain) UIColor *thumbTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
    }
    class func setUIStepper() {
        // UIStepper.h:- (void)setBackgroundImage:(UIImage*)image forState:(UIControlState)state NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIStepper.h:- (UIImage*)backgroundImageForState:(UIControlState)state NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIStepper.h:- (void)setDividerImage:(UIImage*)image forLeftSegmentState:(UIControlState)leftState rightSegmentState:(UIControlState)rightState NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIStepper.h:- (UIImage*)dividerImageForLeftSegmentState:(UIControlState)state rightSegmentState:(UIControlState)state NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIStepper.h:- (void)setIncrementImage:(UIImage *)image forState:(UIControlState)state NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIStepper.h:- (UIImage *)incrementImageForState:(UIControlState)state NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIStepper.h:- (void)setDecrementImage:(UIImage *)image forState:(UIControlState)state NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIStepper.h:- (UIImage *)decrementImageForState:(UIControlState)state NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
    }
    class func setUISwitch() {
        // UISwitch.h:@property(nonatomic, retain) UIColor *onTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UISwitch.h:@property(nonatomic, retain) UIColor *thumbTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UISwitch.h:@property(nonatomic, retain) UIImage *onImage NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UISwitch.h:@property(nonatomic, retain) UIImage *offImage NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
    }
    class func setUITabBar() {
        // UITabBar.h:@property(nonatomic,retain) UIColor *barTintColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // default is nil
       // [[UITabBar appearance] setBarTintColor:[AppUIManager getColorOfType:kAUCColorTypeTint]];
        //[[UITabBar appearance] setBarTintColor:[UIColor clearColor]];
        // UITabBar.h:@property(nonatomic,retain) UIColor *selectedImageTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        //[[UITabBar appearance] setSelectedImageTintColor:[AppUIManager getColorOfType:kAUCColorTypeTint withBrightness:kAUCColorScaleLighter]];
        // UITabBar.h:@property(nonatomic,retain) UIImage *backgroundImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UITabBar.h:@property(nonatomic,retain) UIImage *selectionIndicatorImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UITabBar.h:@property(nonatomic,retain) UIImage *shadowImage NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UITabBar.h:@property(nonatomic) UITabBarItemPositioning itemPositioning NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
        // UITabBar.h:@property(nonatomic) CGFloat itemWidth NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
        // UITabBar.h:@property(nonatomic) CGFloat itemSpacing NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
        // UITabBar.h:@property(nonatomic) UIBarStyle barStyle NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
        //[[UITabBar appearance] setBarStyle:UIBarStyleDefault];
        // UITabBarItem.h:- (void)setTitlePositionAdjustment:(UIOffset)adjustment NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UITabBarItem.h:- (UIOffset)titlePositionAdjustment NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        
        // set color of unselected text to white
        // [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppUIManager getColorOfType:kAUCColorTypeTintUnselected], NSForegroundColorAttributeName, nil]  forState:UIControlStateNormal];
        // set color of unselected text to white
        //[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppUIManager getColorOfType:kAUCColorTypeTintSelected], NSForegroundColorAttributeName, nil]  forState:UIControlStateSelected];
    }
    class func setUITableView() {
        // UITableView.h:@property (nonatomic)          UIEdgeInsets                separatorInset NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR; // allows customization of the frame of cell separators
        // UITableView.h:@property(nonatomic, retain) UIColor *sectionIndexColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;                   // color used for text of the section index
        //[[UITableView appearance] setSectionIndexColor:[UIColor clearColor]];
        // UITableView.h:@property(nonatomic, retain) UIColor *sectionIndexBackgroundColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;         // the background color of the section index while not being touched
        //[[UITableView appearance] setSectionIndexBackgroundColor:[UIColor clearColor]];
        // UITableView.h:@property(nonatomic, retain) UIColor *sectionIndexTrackingBackgroundColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR; // the background color of the section index while it is being touched
        // UITableViewCell.h:@property (nonatomic) UIEdgeInsets                    separatorInset NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR; // allows customization of the separator frame
        
        //[[UITableViewCell appearance] setBackgroundColor:[AppUIManager getColorOfType:kAUCColorTypeBackground]];
        
    }
    class func setUIToolbar() {
        // UIToolbar.h:@property(nonatomic,retain) UIColor *barTintColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // default is nil
        // UIToolbar.h:- (void)setBackgroundImage:(UIImage *)backgroundImage forToolbarPosition:(UIBarPosition)topOrBottom barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIToolbar.h:- (UIImage *)backgroundImageForToolbarPosition:(UIBarPosition)topOrBottom barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
        // UIToolbar.h:- (void)setShadowImage:(UIImage *)shadowImage forToolbarPosition:(UIBarPosition)topOrBottom NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
        // UIToolbar.h:- (UIImage *)shadowImageForToolbarPosition:(UIBarPosition)topOrBottom NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
    }
    class func setUIView() {
        // UIView.h:@property(nonatomic,copy)            UIColor          *backgroundColor UI_APPEARANCE_SELECTOR; // default is nil. Can be useful with the appearance proxy on custom UIView subclasses.
        //[[UIView appearance] setBackgroundColor:[AppUIManager getColorOfType:kAUCColorTypePrimary]];
    }
    
}
