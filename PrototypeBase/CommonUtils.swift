//
//  CommonUtils.swift
//  PrototypeBase
//
//  Created by Bijit on 11/17/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
//import "sys/types.h"
//import "sys/sysctl.h"


class CommonUtils {
    
    // MARK: - singleton
    static let sharedInstance = CommonUtils()
    private init() {
    }
    
    // MARK: -  Class Methods
    class func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // MARK: -  Device Methods
    //    + (NSString *)getAppleDeviceTagOld {
    //    size_t size;
    //    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    //    char *machine = malloc(size);
    //    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    //    /*
    //    Possible values:
    //    "iPhone1,1" = iPhone 1G // 0
    //    "iPhone1,2" = iPhone 3G  // 1
    //    "iPhone2,1" = iPhone 3GS  // 2
    //    "iPod1,1"   = iPod touch 1G // 3
    //    "iPod2,1"   = iPod touch 2G // 4
    //    "iPod3,1"   = iPod touch 3G // 5
    //    "iPad1,1"   = iPad // 6
    //    */
    //    NSString *platform = [[NSString alloc] initWithCString:machine encoding:NSUTF8StringEncoding];
    //
    //    int deviceType=0;
    //    NSString *deviceString;
    //
    //    if(([platform isEqualToString:@"i386"]==YES)||([platform isEqualToString:@"x86_64"]==YES)) {
    //    NSString *model= [[UIDevice currentDevice] model];
    //    NSString *iPadSimulator = @"iPad Simulator";
    //    if([model compare:iPadSimulator] == NSOrderedSame) {
    //    deviceType = 2;             // simulator MAC 32 bit - iPad
    //    deviceString=kiOSDeviceTagSimulatoriPad;
    //    }
    //    else{
    //    deviceType = 1;             // simulator MAC 32 bit - iPhone
    //    deviceString=kiOSDeviceTagSimulatoriPhone;
    //    }
    //
    //    }
    //    else if([platform isEqualToString:@"iPod1,1"]==YES) {
    //    deviceType = 11;         // iPod Touch first generation 1G
    //    deviceString=kiOSDeviceTagiPodFirstGeneration;
    //    }
    //    else if([platform isEqualToString:@"iPod2,1"]==YES) {
    //    deviceType = 12;         // iPod Touch second generation 2G
    //    deviceString=kiOSDeviceTagiPodSecondGeneration;
    //    }
    //    else if([platform isEqualToString:@"iPod3,1"]==YES) {
    //    deviceType = 13;         // iPod Touch third generation 3G
    //    deviceString=kiOSDeviceTagiPodThirdGeneration;
    //    }
    //    else if([platform isEqualToString:@"iPod4,1"]==YES) {
    //    deviceType = 13;         // iPod Touch third generation 3G
    //    deviceString=kiOSDeviceTagiPodFirstGeneration;
    //    }
    //    else if([platform isEqualToString:@"iPhone1,1"]==YES) {
    //    deviceType = 21;         // first gen iPhone 1G
    //    deviceString=kiOSDeviceTagiPhoneFirstGeneration;
    //    }
    //    else if([platform isEqualToString:@"iPhone1,2"]==YES) {
    //    deviceType = 22;         // for the 3G model
    //    deviceString=kiOSDeviceTagiPhoneThirdGeneration;
    //    }
    //    else if([platform isEqualToString:@"iPhone2,1"]==YES) {
    //    deviceType = 23;         // for the 3GS model
    //    deviceString=kiOSDeviceTagiPhoneThirdGenerationS;
    //    }
    //    else if([platform isEqualToString:@"iPhone3,1"]==YES) {
    //    deviceType = 24;         // for the 4G model
    //    deviceString=kiOSDeviceTagiPhoneForthGeneration;
    //    }
    //    else if([platform isEqualToString:@"iPhone3,3"]==YES) {
    //    deviceType = 25;         // for the 4G Verizon model
    //    deviceString=kiOSDeviceTagiPhoneForthGenerationV;
    //    }
    //    else if([platform isEqualToString:@"iPhone4,1"]==YES) {
    //    deviceType = 25;         // for the 4GS model
    //    deviceString=kiOSDeviceTagiPhoneForthGenerationS;
    //    }
    //    else if ([platform isEqualToString:@"iPad1,1"]==YES) {
    //    deviceType = 31;         // iPad
    //    deviceString=kiOSDeviceTagiPadFirstGeneration;
    //    }
    //    else if ([platform isEqualToString:@"iPad2,1"]==YES) {
    //    deviceType = 32;         // iPad 2 WiFi
    //    deviceString=kiOSDeviceTagiPadSecondGenerationWF;
    //    }
    //    else if ([platform isEqualToString:@"iPad2,2"]==YES) {
    //    deviceType = 32;         // iPad 2 GSM
    //    deviceString=kiOSDeviceTagiPadSecondGenerationGSM;
    //    }
    //    else if ([platform isEqualToString:@"iPad2,3"]==YES) {
    //    deviceType = 32;         // iPad 2 CDMA
    //    deviceString=kiOSDeviceTagiPadSecondGenerationCDMA;
    //    }
    //    else {
    //    deviceString=kiOSDeviceTagUnknown;
    //    deviceType = 0;
    //    }
    //
    //    // release variables
    //    free(machine);
    //
    //    if(deviceType==0) {
    //
    //    }
    //    // NSPLogBLog(@"Device Type: %@ [%d]",platform,deviceType);
    //
    //    return deviceString;
    //    }
    //
    //    + (NSString *)getUUID {
    //    //return [[UIDevice currentDevice] uniqueIdentifier];
    //    return @"Create your own";
    //    }
    //    + (BOOL)isiPad {
    //    return IS_IPAD;
    //    }
    //    + (float)getDisplayPPI{
    //    float  ppi;
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //    ppi = 132;
    //    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    //    ppi = 163;
    //    } else {
    //    ppi = 160;
    //    }
    //    return ppi;
    //    }
    //    + (float)getDisplayDPI{
    //    float scale = 1;
    //    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
    //    scale = [[UIScreen mainScreen] scale];
    //    }
    //    return scale*[CommonUtility getDisplayPPI];
    //    }
    //
    //    // MARK: -  App Info Methods
    //    + (NSString *)getOSVersion {
    //    return [[UIDevice currentDevice] systemVersion];
    //    }
    //    +(NSString *)getDeviceModel {
    //    return [[UIDevice currentDevice] model];
    //    }
    //    +(NSString *)getDeviceName {
    //    return [[UIDevice currentDevice] name];
    //    }
    //
    //    + (NSString *)getAppVersion {
    //    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    //    }
    //
    //    + (NSString *)getAppName {
    //    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    //    }
    //
    //    +(NSString *)getAppInfo {
    //    return [NSString stringWithFormat:@"%@ V%@",[CommonUtility getAppName],[CommonUtility getAppVersion]];
    //    }
    //
    //    + (NSString *)getAppDeviceAndOSInfo {
    //    return [NSString stringWithFormat:@"%@[%@-%@]",[CommonUtility getAppInfo],[CommonUtility getDeviceModel],[CommonUtility getOSVersion]];
    //    }
    //
    //    // MARK: -  Display Mathods
    //    + (void)displayActionSheetWithTitle:(NSString *)title cancelButton:(NSString *)cancelButton destructiveButton:(NSString *)destructiveButton customButtons:(NSArray *)buttonTextArray delegate:(id)delegate {
    //    // set action sheet
    //    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:title
    //    delegate:delegate
    //    cancelButtonTitle:cancelButton
    //    destructiveButtonTitle:destructiveButton
    //    otherButtonTitles:nil];
    //    // add custom button
    //    for(NSString *tString in buttonTextArray) {
    //    [actionSheet addButtonWithTitle:tString];
    //    // NSPLogBLog(@"Botton Index: %d",bIndex);
    //    }
    //
    //    // set style
    //    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    //
    //    // display
    //    [actionSheet showInView:[delegate view]];
    //
    //    // release
    //    //[actionSheet release];
    //
    //    /** Example of how to use this method
    //    // call from a view controller
    //    1. Add ActionSheetDelegate to viewController
    //
    //    2. [CommonUtility displayActionSheetWithTitle:@"Title of the action sheet."
    //    cancelButton:@"cancel"
    //    destructiveButton:nil
    //    customButtons:[NSArray arrayWithObjects:@"Button 1",@"Button 2",nil]
    //    delegate:self];
    //
    //    3. Button actions using delegate
    //    - (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //    //Button actions using delegate
    //    int customButtonStartIndex = (actionSheet.cancelButtonIndex>=0)?1:0;
    //    customButtonStartIndex += (actionSheet.destructiveButtonIndex>=0)?1:0;
    //    int totalCustomButtons = actionSheet.numberOfButtons - customButtonStartIndex;
    //
    //    // NSPLogBLog(@"bIndeX: %d cIndex:%d",buttonIndex,customButtonStartIndex);
    //
    //    // check if cancelButton Pressed
    //    if(actionSheet.cancelButtonIndex==buttonIndex){
    //    // NSPLogBLog(@"Action for C Button");
    //    }
    //    else if(actionSheet.destructiveButtonIndex==buttonIndex){
    //    // NSPLogBLog(@"Action for D Button");
    //    }
    //    else{
    //    for(int ind=0;ind<totalCustomButtons;ind++){
    //    if(customButtonStartIndex+ind==buttonIndex){
    //    // action for custom button
    //    // NSPLogBLog(@"Action for Button %d",ind+customButtonStartIndex);
    //    }
    //    }
    //    }
    //
    //    }
    //
    //    */
    //    }
    //
    //    + (void)displayActionSheetFromTabBarWithTitle:(NSString *)title cancelButton:(NSString *)cancelButton destructiveButton:(NSString *)destructiveButton customButtons:(NSArray *)buttonTextArray delegate:(id)delegate {
    //    // set action sheet
    //    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:title
    //    delegate:delegate
    //    cancelButtonTitle:cancelButton
    //    destructiveButtonTitle:destructiveButton
    //    otherButtonTitles:nil];
    //    // add custom button
    //    for(NSString *tString in buttonTextArray) {
    //    [actionSheet addButtonWithTitle:tString];
    //    // NSPLogBLog(@"Botton Index: %d",bIndex);
    //    }
    //
    //    // set style
    //    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    //
    //    // display
    //    [actionSheet showInView:[[delegate tabBarController] view]];
    //
    //    // release
    //    //[actionSheet release];
    //
    //    /* See displayActionSheetWithTitle: method for how to use*/
    //
    //    }
    //
    //    + (void)displayAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton customButtons:(NSArray *)buttonTextArray delegate:(id)delegate {
    //    // set action sheet
    //    UIAlertView *alertView=[[UIAlertView alloc]  initWithTitle:title
    //    message:message
    //    delegate:delegate
    //    cancelButtonTitle:cancelButton
    //    otherButtonTitles:nil];
    //
    //    // add custom button
    //    for(NSString *tString in buttonTextArray) {
    //    [alertView addButtonWithTitle:tString];
    //    // NSPLogBLog(@"Botton Index: %d",bIndex);
    //    }
    //
    //    // display
    //    [alertView show];
    //
    //    // release
    //    //[alertView release];
    //
    //    /** Example of how to use this method
    //    // call from a view controller
    //    1. Add AlertviewDelegate to viewController
    //
    //
    //    // MARK: -  AlertView Methods
    //    - (void)displayAlertView{
    //    [CommonUtility displayAlertViewWithTitle:@"Not Implemented"
    //    message:@"This function is not yet implemented."
    //    cancelButton:@"OK"
    //    customButtons:[NSArray arrayWithObjects:@"Done",nil]
    //    delegate:self];
    //    }
    //
    //    // Can separate views by title [is necessary with tag]
    //    - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    //    //Button actions using delegate
    //    int customButtonStartIndex = (alertView.cancelButtonIndex>=0)?1:0;
    //    int totalCustomButtons = alertView.numberOfButtons - customButtonStartIndex;
    //
    //    // NSPLogBLog(@"bIndeX: %d cIndex:%d",buttonIndex,customButtonStartIndex);
    //
    //    // check if cancelButton Pressed
    //    if(alertView.cancelButtonIndex==buttonIndex){
    //    // NSPLogBLog(@"Action for C Button");
    //    }
    //    else{
    //    for(int ind=0;ind<totalCustomButtons;ind++){
    //    if(customButtonStartIndex+ind==buttonIndex){
    //    // action for custom button
    //    // NSPLogBLog(@"Action for Button %d",ind+customButtonStartIndex);
    //    }
    //    }
    //    }
    //    }
    //
    //    */
    //    }
    //
    //
    //
    //    + (void)displayAlertWithTitle:(NSString *)title message:(NSString *)msg delegate:(id)delegate {
    //    // display alert
    //    UIAlertView *alert = [[UIAlertView alloc]
    //    initWithTitle:title
    //    message:msg
    //    delegate:delegate
    //    cancelButtonTitle:nil
    //    otherButtonTitles:@"Ok",nil];
    //    // show alert
    //    [alert show];
    //
    //    // release alert
    //    //[alert release];
    //    }
    //
    //    // MARK: -  Math Methods
    //    + (NSInteger)hexToDec:(NSString *)hexString {
    //    // returns positive int for valid inout or -1 for invalid input
    //    // trim string  and add hex prefix
    //    //NSString *hexNum = [[NSString alloc] initWithString:[[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByAppendingString:@"0X"]];
    //    NSString *hexNum = [[NSString alloc] initWithString:[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    //    // now convert
    //    NSScanner* pScanner = [NSScanner scannerWithString:hexNum];
    //    // relase string
    //    //[hexNum release];
    //
    //    unsigned int decNum;
    //    BOOL isValid = [pScanner scanHexInt: &decNum];
    //
    //    // NSPLogBLog(@"Hex String: %@, Dec Number: %d",hexNum,decNum);
    //
    //    if(isValid==YES) {
    //    return decNum;
    //    }
    //    else{
    //    return -1;
    //    }
    //    }
    //
    //    // MARK: -  Vec functions
    //    + (float)vecMax:(float *)vec ofSize:(int)aSize maxIndex:(int *)maxInd {
    //    if(aSize==0) {
    //    return NSNotFound;
    //    }
    //    float maxVal = vec[0];
    //    *maxInd=0;
    //    float cVal;
    //
    //    for(int ind=1; ind<aSize; ind++) {
    //    cVal = vec[ind];
    //    if(maxVal < cVal) {
    //    maxVal = cVal;
    //    *maxInd=ind;
    //    }
    //    }
    //
    //    return maxVal;
    //    }
    //    + (float)vecMin:(float *)vec ofSize:(int)aSize minIndex:(int *)minInd {
    //    if(aSize==0) {
    //    return NSNotFound;
    //    }
    //    float minVal = vec[0];
    //    *minInd=0;
    //    float cVal;
    //
    //    for(int ind=1; ind<aSize; ind++) {
    //    cVal = vec[ind];
    //    if(minVal > cVal) {
    //    minVal = cVal;
    //    *minInd=ind;
    //    }
    //    }
    //
    //    return minVal;
    //    }
    //    + (float)intvecMax:(int *)vec ofSize:(int)aSize maxIndex:(int *)maxInd{
    //    if(aSize==0) {
    //    return NSNotFound;
    //    }
    //    int maxVal = vec[0];
    //    *maxInd=0;
    //    int cVal;
    //
    //    for(int ind=1; ind<aSize; ind++) {
    //    cVal = vec[ind];
    //    if(maxVal < cVal) {
    //    maxVal = cVal;
    //    *maxInd=ind;
    //    }
    //    }
    //
    //    return maxVal;
    //    }
    //    + (float)intvecMin:(int *)vec ofSize:(int)aSize minIndex:(int *)minInd{
    //    if(aSize==0) {
    //    return NSNotFound;
    //    }
    //    int minVal = vec[0];
    //    *minInd=0;
    //    int cVal;
    //
    //    for(int ind=1; ind<aSize; ind++) {
    //    cVal = vec[ind];
    //    if(minVal > cVal) {
    //    minVal = cVal;
    //    *minInd=ind;
    //    }
    //    }
    //
    //    return minVal;
    //    }
    //    // MARK: -  Array functions
    //    + (float)maxValInArray:(NSArray *)fArray {
    //    int asize = (int)[fArray count];
    //    if(asize==0) {
    //    return NSNotFound;
    //    }
    //    float maxVal = [[fArray objectAtIndex:0] floatValue];
    //    float cVal;
    //
    //    for(int ind=1; ind<[fArray count]; ind++) {
    //    cVal = [[fArray objectAtIndex:ind] floatValue];
    //    if(maxVal < cVal) {
    //    maxVal = cVal;
    //    }
    //    }
    //
    //    return maxVal;
    //    }
    //    + (float)minValInArray:(NSArray *)fArray {
    //    int asize = (int)[fArray count];
    //    if(asize==0) {
    //    return NSNotFound;
    //    }
    //    float minVal = [[fArray objectAtIndex:0] floatValue];
    //    float cVal;
    //
    //    for(int ind=1; ind<[fArray count]; ind++) {
    //    cVal = [[fArray objectAtIndex:ind] floatValue];
    //    if(minVal > cVal) {
    //    minVal = cVal;
    //    }
    //    }
    //
    //    return minVal;
    //    }
    //
    //    + (NSArray *)getArrayWithIntFrom:(NSInteger)lLim to:(NSInteger)uLim {
    //    NSMutableArray *mArray =[[NSMutableArray alloc] init];
    //    for(int ind=(int)lLim; ind<=uLim; ind++) {
    //    [mArray addObject:[NSNumber numberWithInt:ind]];
    //    }
    //
    //    return (NSArray *)mArray;
    //    }
    //    + (NSArray *)reverseArray:(NSArray *)array {
    //    return [[array reverseObjectEnumerator] allObjects];
    //    }
    //    + (NSArray *)attchTag:(NSString *)tag toTextArray:(NSArray *)array{
    //    NSMutableArray *mArray =[[NSMutableArray alloc] init];
    //    for(NSString *text in array) {
    //    [mArray addObject:[text stringByAppendingString:tag]];
    //    }
    //    return (NSArray *)mArray;
    //    }
    //
    //    +(NSArray *)filterArray:(NSArray *)sArray withElementsThatEndsWith:(NSString *)estring{
    //    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"SELF ENDSWITH %@",estring];
    //    return [sArray filteredArrayUsingPredicate:fltr];
    //
    //    }
    //    + (NSArray *)sortArrayWithString:(NSArray *)sarray{
    //    return [sarray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    //    }
    //    // MARK: -  String functions
    //    + (BOOL)isEmptyString:(NSString *)string {
    //    return (string==nil||[[string stringByTrimmingCharactersInSet:
    //    [NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0);
    //    }
    //
    //    + (NSString *)trimString:(NSString *)string {
    //    return [string stringByTrimmingCharactersInSet:
    //    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //
    //    }
    //
    // MARK: -  Randomizarion and vector Methods
    //    + (void)normalizeArray:(float *)array withSize:(int)size {
    //    float sum=0.0;
    //    for(int ind=0; ind<size; ind++) {
    //    sum += array[ind];
    //    }
    //    // normalize array
    //    if(sum!=0.0) {
    //    for(int ind=0; ind<size; ind++) {
    //    array[ind]=array[ind]/sum;
    //    }
    //    }
    //    }
    //
    //    + (int)isNumber:(int)number inArray:(int *)array withSize:(int)arraySize {
    //    int atIndex = -1;
    //
    //    for(int ind=0; ind<arraySize; ind++) {
    //    if(*(array+ind)==number) {
    //    atIndex = ind;
    //    break;
    //    }
    //    }
    //    return atIndex;
    //    }
    //
    //    + (int)removeInt:(int)number fromArray:(int *)arrayName withSize:(int)arraySize {
    //    int indl, ind;
    //    int newArraySize = 0;
    //    for     (ind=0; ind<arraySize; ind++) {
    //    if (*(arrayName+ind)==number) {
    //    newArraySize=arraySize-1;
    //    break;
    //    }
    //    }
    //
    //    for(indl=ind+1; indl<arraySize; indl++) {
    //    *(arrayName+indl-1)=*(arrayName+indl);
    //    }
    //
    //    return newArraySize;
    //    }
    //
    //
    //    + (void)randomizeArray:(int *)array withSize:(int)arraySize {
    //    int temp;
    //    for(int ind = arraySize-1; ind>=0; ind--) {
    //    for(int indx = ind+1; indx<arraySize; indx++) {
    //    if([CommonUtility  pickRandom:2]==0) {
    //    //swap contents
    //    temp = *(array+ind);
    //    *(array+ind)= *(array+indx);
    //    *(array+indx)= temp;
    //    }
    //    }
    //    }
    //    }
    //
    //    + (NSArray *)randomizeNSArray:(NSArray *)array withCorrectIndex:(int *)cind {
    //    int asize =(int)[array count];
    //    int rindex[asize];
    //    for(int ind = 0; ind<asize; ind++) {
    //    rindex[ind]=ind;
    //    }
    //    [CommonUtility randomizeArray:rindex withSize:asize];
    //
    //    int ocind = *cind;
    //    NSMutableArray *marray=[[NSMutableArray alloc] init];
    //    for(int ind = 0; ind<asize; ind++) {
    //    [marray addObject:[array objectAtIndex:rindex[ind]]];
    //    if(rindex[ind]==ocind) {
    //    *cind=ind;
    //    }
    //    }
    //
    //    return (NSArray *)marray;
    //    }
    
    func pickRandom(maxInt:Int) -> Int {
        return Int(arc4random_uniform(UInt32(maxInt)))
    }
    
    func pickRandomFrom(minLimit:Int,  to maxLimit: Int) -> Int {
        var randVal: Int
        
        if  maxLimit >= minLimit {
            randVal = self.pickRandom((maxLimit-minLimit)+1)+minLimit;
        }
        else {
            randVal = self.pickRandom((minLimit-maxLimit)+1)+maxLimit;
        }
        
        return randVal;
    }
    //
    //    + (BOOL)findRandomIndices:(int *)array withSize:(int)arraySize forMaxInd:(int)maxInd {
    //    BOOL isSuccessful = NO;
    //    BOOL doesExist;
    //    int currentPick;
    //    int indexCounter = 0;
    //
    //    if(arraySize<maxInd) {
    //    while(isSuccessful==NO) {
    //    // pick a random number
    //    currentPick = [CommonUtility  pickRandom:maxInd];
    //
    //    // if current pick is new
    //    doesExist = NO;
    //    for(int ind=0; ind<indexCounter; ind++) {
    //    doesExist = (*(array+ind)==currentPick);
    //    if(doesExist==YES) {
    //    break;
    //    }
    //    }
    //
    //    if(doesExist==NO) {           // current pick is new
    //    *(array+indexCounter)=currentPick;
    //    indexCounter++;
    //    isSuccessful=(indexCounter==arraySize);
    //    }
    //    }
    //    }
    //    else if (arraySize==maxInd) {
    //    // fill array with all indices
    //    for(int ind=0; ind<arraySize; ind++) {
    //    *(array+ind)=ind;
    //    }
    //    isSuccessful=YES;
    //    }
    //
    //    return isSuccessful;
    //    }
    //
    //    /*
    //    +(BOOL)generateChoiceVec:(int *)choices ofSize:(int)vecSize withMax:(int)maxVal min:(int)minVal correctVal:(int)correctVal andIndex:(int *)index {
    //    int range = maxVal-minVal+1;
    //    if((range)<vecSize || vecSize<1) {
    //    return NO;
    //    }
    //
    //    // get vecSize-1 random elements
    //    // fill vec with numbers from minVal to MaxVal
    //    int tvec[range];
    //    for(int ind=0; ind<range; ind++) {
    //    tvec[ind]=ind+minVal;
    //    }
    //    // randomize tvec
    //    [CommonUtility randomizeArray:tvec withSize:range];
    //    [CommonUtility removeInt:correctVal fromArray:tvec withSize:range];
    //
    //    // fill chioces array
    //    for(int ind=0; ind<vecSize-1; ind++) {
    //    choices[ind]=tvec[ind];
    //    }
    //    choices[vecSize-1]=correctVal;
    //
    //    // randomize choices
    //    [CommonUtility randomizeArray:choices withSize:vecSize];
    //    // get index
    //    *(index) =[CommonUtility isNumber:correctVal inArray:choices withSize:vecSize];
    //
    //    if(*(index)<0) {
    //    return NO;
    //    }
    //
    //    // no error
    //    return YES;
    //    }
    //
    //    +(BOOL)generateRandomVec:(int *)choices ofSize:(int)vecSize withMax:(int)maxVal min:(int)minVal excludingVal:(int)correctVal {
    //    int range = maxVal-minVal+1;
    //    if(range<vecSize || vecSize<1) {
    //    return NO;
    //    }
    //
    //    // get vecSize-1 random elements
    //    // fill vec with numbers from minVal to MaxVal
    //    int tvec[range];
    //    for(int ind=0; ind<range; ind++) {
    //    tvec[ind]=ind+minVal;
    //    }
    //    // randomize tvec
    //    [CommonUtility randomizeArray:tvec withSize:range];
    //    [CommonUtility removeInt:correctVal fromArray:tvec withSize:range];
    //
    //    // fill chioces array
    //    for(int ind=0; ind <vecSize; ind++) {
    //    choices[ind] = tvec[ind];
    //    }
    //    // no error
    //    return YES;
    //    }
    //    */
    //
    //
    // MARK: -  File Manager Methods
    //    + (BOOL)createEmptyFile:(NSString *)fileName inDir:(NSString *)dir {
    //    // File Manager
    //    NSFileManager *FileManager =[NSFileManager defaultManager];
    //    return [FileManager createFileAtPath:[dir stringByAppendingPathComponent:fileName] contents:nil attributes:nil];
    //    }
    //
    //    + (BOOL)deleteDir:(NSString *)dir {
    //    return [[NSFileManager defaultManager] removeItemAtPath:dir error:nil];
    //    }
    //    + (BOOL)deleteFile:(NSString *)filePath {
    //    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    //    }
    //
    //    + (BOOL)createDir:(NSString *)dir {
    //    // File Manager
    //    NSFileManager *FileManager =[NSFileManager defaultManager];
    //    return [FileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    //    }
    //
    //    + (BOOL)doesFileExist:(NSString *)path {
    //    // File Manager
    //    NSFileManager *FileManager =[NSFileManager defaultManager];
    //    return [FileManager fileExistsAtPath:path];
    //    }
    //
    //    + (BOOL)doesFileExistInResourceDir:(NSString *)fileName {
    //    // File Manager
    //    NSFileManager *FileManager =[NSFileManager defaultManager];
    //    return [FileManager fileExistsAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName]];
    //    }
    //
    func getResourceRootDirectory() -> String {
        return NSBundle.mainBundle().resourcePath!
    }
    func getDocumentRootDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    }
    //
    //    + (NSArray *)getFileListInDir:(NSString *)path{
    //    return [CommonUtility getFileListByNameInDir:path];
    //    }
    //
    //    + (NSArray *)getFileListByNameInDir:(NSString *)path{
    //    NSFileManager *fm = [NSFileManager defaultManager];
    //    NSURL *url =[NSURL fileURLWithPath:path isDirectory:YES];
    //    return [fm contentsOfDirectoryAtURL:url
    //    includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLNameKey,nil]
    //    options:NSDirectoryEnumerationSkipsSubdirectoryDescendants
    //    error:nil];
    //    }
    //    + (NSArray *)getFileListByCreationDateInDir:(NSString *)path{
    //    NSFileManager *fm = [NSFileManager defaultManager];
    //    NSURL *url =[NSURL fileURLWithPath:path isDirectory:YES];
    //    return [fm contentsOfDirectoryAtURL:url
    //    includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLCreationDateKey,nil]
    //    options:NSDirectoryEnumerationSkipsSubdirectoryDescendants
    //    error:nil];
    //    }
    //    + (NSArray *)getFileListByMidificationDateInDir:(NSString *)path{
    //    NSFileManager *fm = [NSFileManager defaultManager];
    //    NSURL *url =[NSURL fileURLWithPath:path isDirectory:YES];
    //    return [fm contentsOfDirectoryAtURL:url
    //    includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLContentModificationDateKey,nil]
    //    options:NSDirectoryEnumerationSkipsSubdirectoryDescendants
    //    error:nil];
    //    }
    //
    //    // MARK: -  Debug Log File Methods
    //    + (NSString *)getDebugFilePath{
    //    return [[CommonUtility getDocumentRootDirectory] stringByAppendingPathComponent:@"appDebugLogFile.txt"];
    //    }
    //    + (BOOL)writeToDebugFile:(NSString *)text{
    //    NSString *debugFile = [CommonUtility getDebugFilePath];
    //    //FILE *fopen(const char *filename, const char *mode);
    //    FILE *file_handle = fopen([debugFile cStringUsingEncoding:NSASCIIStringEncoding],[@"w" cStringUsingEncoding:NSASCIIStringEncoding]);
    //    fprintf(file_handle,"%s\n",[text UTF8String]);
    //    return fclose(file_handle)==0;
    //    }
    //    + (BOOL)appendToDebugFile:(NSString *)text{
    //    NSString *debugFile = [CommonUtility getDebugFilePath];
    //    //FILE *fopen(const char *filename, const char *mode);
    //    FILE *file_handle = fopen([debugFile cStringUsingEncoding:NSASCIIStringEncoding],[@"a" cStringUsingEncoding:NSASCIIStringEncoding]);
    //    fprintf(file_handle,"%s\n",[text UTF8String]);
    //    return fclose(file_handle)==0;
    //    }
    //
    //    // MARK: -  File Manager Methods with URL - preffered for iOS 4.0+
    //    +(NSURL *)getURLForDocumentDirectory {
    //    return [[NSFileManager defaultManager]
    //    URLForDirectory:NSDocumentDirectory
    //    inDomain:NSUserDomainMask
    //    appropriateForURL:nil
    //    create:YES
    //    error:nil];
    //    }
    //    +(NSURL *)getURLForSupportDirectory {
    //    return [[NSFileManager defaultManager]
    //    URLForDirectory:NSApplicationSupportDirectory
    //    inDomain:NSUserDomainMask
    //    appropriateForURL:nil
    //    create:YES
    //    error:nil];
    //    }
    //
    //    + (BOOL)createDirectoryInDocumentDirectory:(NSString *)dir {
    //    // File Manager
    //    NSFileManager *FileManager =[NSFileManager defaultManager];
    //    return [FileManager createDirectoryAtURL:[[CommonUtility getURLForDocumentDirectory]
    //    URLByAppendingPathComponent:dir
    //    isDirectory:YES]
    //    withIntermediateDirectories:YES
    //    attributes:nil
    //    error:nil];
    //    }
    //    + (BOOL)createDirectoryInSupportDirectory:(NSString *)dir {
    //    // File Manager
    //    NSFileManager *FileManager =[NSFileManager defaultManager];
    //    return [FileManager createDirectoryAtURL:[[CommonUtility getURLForSupportDirectory]
    //    URLByAppendingPathComponent:dir
    //    isDirectory:YES]
    //    withIntermediateDirectories:YES
    //    attributes:nil
    //    error:nil];
    //    }
    //    +(BOOL)createDirectoryWithFullURL:(NSURL *)url {
    //    // File Manager
    //    NSFileManager *FileManager =[NSFileManager defaultManager];
    //    if([FileManager respondsToSelector:@selector(createDirectoryAtURL:withIntermediateDirectories:attributes:error:)])
    //    {
    //    return [FileManager createDirectoryAtURL:url
    //    withIntermediateDirectories:YES
    //    attributes:nil
    //    error:nil];
    //    }
    //
    //    // 4.3 fix
    //    return [CommonUtility createDir:url.path];
    //    }
    //
    //    // MARK: -  Legal Info
    //    + (NSString *)getCopyRightText {
    //    return [NSString stringWithFormat:@"©%d Indriam Inc.",(int)[CommonUtility getCurrentYear]];
    //    }
    //
    //    + (NSString *)getBrandText {
    //    return @"A Mobkoo Product";
    //    }
    //
    //    // MARK: -  Font Related Methods
    //    + (NSArray *) getAllFontFamilyList {
    //    return [UIFont familyNames];
    //    }
    //    + (NSArray *) getAllFontList {
    //    // get all font family
    //    NSArray *fArray = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    //
    //    NSMutableArray *fontArray =[[NSMutableArray alloc] initWithCapacity:1];
    //    NSMutableArray *fontList =[[NSMutableArray alloc] initWithCapacity:1];
    //    // got over all font family
    //    for(NSString *fontFamily in fArray) {
    //    [fontArray setArray:[UIFont fontNamesForFamilyName:fontFamily]];
    //
    //    for(NSString *fontName in fontArray) {
    //    [fontList addObject:fontName];
    //    }
    //    }
    //    return [fontList sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    //    }
    //
    //    + (NSString *) getRandomFont {
    //    NSArray *fArray = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    //
    //    int index = [CommonUtility  pickRandom:(int)[fArray count]];
    //    // get array for the picked family
    //    NSArray *fontArray = [[NSArray alloc] initWithArray:[UIFont fontNamesForFamilyName:[fArray objectAtIndex:index]]];
    //    // select a font
    //    index = [CommonUtility  pickRandom:(int)[fontArray count]];
    //    // return the selected font
    //    return [fontArray objectAtIndex:index];
    //    }
    //    // MARK: - Number methods
    //    +(NSString *)wordsForInt:(NSInteger)val {
    //    return [CommonUtility wordsForNumber:[NSNumber numberWithInt:(int)val]];
    //    }
    //    +(NSString *)wordsForFloat:(float)val {
    //    return [CommonUtility wordsForNumber:[NSNumber numberWithFloat:val]];
    //    }
    //    +(NSString *)wordsForNumber:(NSNumber *)val {
    //    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    //    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    //    return [numberFormatter stringFromNumber:val];
    //    }
    //
    //    // MARK: - Size and Shape methods
    //    + (CGRect)scaleRect:(CGRect)rect byScale:(float)scale {
    //    if(scale==1.0||scale<0) {
    //    return rect;
    //    }
    //    return CGRectMake(rect.origin.x+rect.size.width*(1.0-scale)/2.0,
    //    rect.origin.y+rect.size.height*(1.0-scale)/2.0,
    //    rect.size.width*scale,
    //    rect.size.height*scale);
    //
    //    }
    //
    //    + (CGRect)scaleRect:(CGRect)rect byXScale:(float)xscale byYScale:(float)yscale {
    //    if(xscale<0||yscale<0) {
    //    return rect;
    //    }
    //    return CGRectMake(rect.origin.x+rect.size.width*(1.0-xscale)/2.0,
    //    rect.origin.y+rect.size.height*(1.0-yscale)/2.0,
    //    rect.size.width*xscale,
    //    rect.size.height*yscale);
    //
    //    }
    //    + (CGRect)shrinkRect:(CGRect)rect byXPoints:(float)xpoints yPoints:(float)ypoints {
    //    return CGRectMake(rect.origin.x+xpoints/2, rect.origin.y+ypoints/2,rect.size.width-xpoints, rect.size.height-ypoints);
    //    }
    //
    //    + (CGRect)shrinkRect:(CGRect)rect byPoints:(float)points {
    //    return CGRectMake(rect.origin.x+points/2, rect.origin.y+points/2,rect.size.width-points, rect.size.height-points);
    //    }
    //    + (CGRect)expandRect:(CGRect)rect byXPoints:(float)xpoints yPoints:(float)ypoints {
    //    return CGRectMake(rect.origin.x-xpoints/2, rect.origin.y-ypoints/2,rect.size.width+xpoints, rect.size.height+ypoints);
    //    }
    //
    //    + (CGRect)expandRect:(CGRect)rect byPoints:(float)points {
    //    return CGRectMake(rect.origin.x-points/2, rect.origin.y-points/2,rect.size.width+points, rect.size.height+points);
    //    }
    //
    //    + (CGRect)resetAndShrinkRect:(CGRect)rect byPoints:(float)points {
    //    return CGRectMake(points/2,points/2,rect.size.width-points, rect.size.height-points);
    //    }
    //
    //    + (CGRect)resetAndExpandRect:(CGRect)rect byPoints:(float)points {
    //    return CGRectMake(-points/2,-points/2,rect.size.width+points, rect.size.height+points);
    //    }
    //
    //    + (CGRect)offSetRect:(CGRect)rect byX:(float)xpoints byY:(float)ypoints {
    //    // return CGRectMake(rect.origin.x+xpoints,rect.origin.y+ypoints,rect.size.width, rect.size.height);
    //    return CGRectOffset(rect,xpoints,ypoints);
    //    }
    //    + (CGRect)offSetRectToOrigin:(CGRect)rect {
    //    return CGRectMake(0,0,rect.size.width,rect.size.height);
    //    }
    //    + (CGRect)centerRect:(CGRect)rect toPoint:(CGPoint)point {
    //    return CGRectMake(point.x-rect.size.width/2,point.y-rect.size.height/2,rect.size.width, rect.size.height);
    //    }
    //
    //    + (CGRect)centerRect:(CGRect)rect toRect:(CGRect)rectt {
    //    return [CommonUtility centerRect:rect toPoint:[CommonUtility getCenterOfRect:rectt]];
    //    }
    //    + (CGRect)getRectOfSize:(CGSize)size {
    //    return CGRectMake(0,0,size.width,size.height);
    //    }
    //    + (CGRect)getRectOfSize:(CGSize)size withCenter:(CGPoint)center {
    //    return CGRectMake(center.x-size.width/2,center.y-size.height/2,size.width,size.height);
    //    }
    //    + (CGRect)getRectOfSize:(CGSize)size centeredToRect:(CGRect)rect {
    //    return [CommonUtility getRectOfSize:size withCenter:[CommonUtility getCenterOfRect:rect]];
    //    }
    //
    //    + (void)printRect:(CGRect)rect {
    //    DBLog(@"Rect Size:[%.2f, %.2f, %.2f, %.2f]",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    //    }
    //    + (void)printPoint:(CGPoint)point {
    //    DBLog(@"Point:[%.2f, %.2f]",point.x,point.y);
    //    }
    //    + (CGRect)flipRect:(CGRect)rect {
    //    return CGRectMake(rect.origin.x,rect.origin.y,rect.size.height, rect.size.width);
    //    }
    //    + (CGPoint)flipXYCoordinates:(CGPoint)point {
    //    return CGPointMake(point.y, point.x);
    //    }
    //    + (CGPoint)getCenterOfRect:(CGRect)rect {
    //    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    //    }
    //    + (CGPoint)getLeftTopPointOfRect:(CGRect)rect {
    //    return CGPointMake(rect.origin.x,rect.origin.y);
    //    }
    //    + (CGPoint)getRightTopPointOfRect:(CGRect)rect {
    //    return CGPointMake(rect.origin.x+rect.size.width,rect.origin.y);
    //    }
    //    + (CGPoint)getLeftBottomPointOfRect:(CGRect)rect {
    //    return CGPointMake(rect.origin.x,rect.origin.y+rect.size.height);
    //    }
    //    + (CGPoint)getRightBottomPointOfRect:(CGRect)rect {
    //    return CGPointMake(rect.origin.x+rect.size.width,rect.origin.y+rect.size.height);
    //    }
    //
    //    + (CGPoint)getPoint:(CGPoint)point withXOffset:(float)xoffset {
    //    return CGPointMake(point.x+xoffset,point.y);
    //    }
    //    + (CGPoint)getPoint:(CGPoint)point withYOffset:(float)yoffset {
    //    return CGPointMake(point.x,point.y+yoffset);
    //    }
    //    + (CGPoint)getPoint:(CGPoint)point withXOffset:(float)xoffset andYOffset:(float)yoffset {
    //    return CGPointMake(point.x+xoffset,point.y+yoffset);
    //    }
    //    + (float)distanceBetweenPoint:(CGPoint)point1 point:(CGPoint)point2 {
    //    float xd=point1.x-point2.x;
    //    float yd=point1.y-point2.y;
    //    return sqrt(xd*xd+yd*yd);
    //    }
    //    // MARK: -  Color Methods
    //    +(void)getRGBValues:(CGFloat *)rgb fromUIColor:(UIColor *)color {
    //    if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
    //    [color getRed:&rgb[0] green:&rgb[1] blue:&rgb[2] alpha:&rgb[3]];
    //    } else {
    //    const CGFloat *components = CGColorGetComponents(color.CGColor);
    //    rgb[0] = components[0];
    //    rgb[1] = components[1];
    //    rgb[2]= components[2];
    //    rgb[3] = components[3];
    //    }
    //    }
    //    + (UIColor *)getColorFromHSBAVec:(float *)hsba {
    //    return [UIColor colorWithHue:fmodf(hsba[0],1.0) saturation:hsba[1] brightness:hsba[2] alpha:hsba[3]];
    //    }
    //    + (UIColor *)getColorFromHSBACVec:(const float *)hsba {
    //    return [UIColor colorWithHue:fmodf(hsba[0],1.0) saturation:hsba[1] brightness:hsba[2] alpha:hsba[3]];
    //    }
    //    + (UIColor *)getColor:(UIColor *)color withOpacity:(float)opacity {
    //    float hsba[4];
    //    // get values
    //    [color getHue:(CGFloat *)&hsba[0] saturation:(CGFloat *)&hsba[1] brightness:(CGFloat *)&hsba[2] alpha:(CGFloat *)&hsba[3]];
    //    // return values
    //    return [UIColor colorWithHue:hsba[0] saturation:hsba[1] brightness:hsba[2] alpha:opacity];
    //    }
    //
    //    + (UIColor *)getColor:(UIColor *)color withScaledOpacity:(float)scale {
    //    if(scale==1.0||scale<0) {
    //    return color;
    //    }
    //    float hsba[4];
    //    // get values
    //    [color getHue:(CGFloat *)&hsba[0] saturation:(CGFloat *)&hsba[1] brightness:(CGFloat *)&hsba[2] alpha:(CGFloat *)&hsba[3]];
    //    // return values
    //    return [UIColor colorWithHue:hsba[0] saturation:hsba[1] brightness:hsba[2] alpha:hsba[3]*scale];
    //    }
    //
    //    + (UIColor *)getColor:(UIColor *)color withBrightness:(float)brightness {
    //    float hsba[4];
    //    // get values
    //    [color getHue:(CGFloat *)&hsba[0] saturation:(CGFloat *)&hsba[1] brightness:(CGFloat *)&hsba[2] alpha:(CGFloat *)&hsba[3]];
    //    // return values
    //    return [UIColor colorWithHue:hsba[0] saturation:hsba[1] brightness:brightness alpha:hsba[3]];
    //    }
    //    + (UIColor *)getColor:(UIColor *)color withScaledBrightness:(float)scale {
    //    if(scale==1.0) {
    //    return color;
    //    }
    //    if(scale<0.0){
    //    scale=0.0;
    //    }
    //    float hsba[4];
    //    // get values
    //    [color getHue:(CGFloat *)&hsba[0] saturation:(CGFloat *)&hsba[1] brightness:(CGFloat *)&hsba[2] alpha:(CGFloat *)&hsba[3]];
    //    // return values
    //    return [UIColor colorWithHue:hsba[0] saturation:hsba[1] brightness:hsba[2]*scale alpha:hsba[3]];
    //    }
    //    + (UIColor *)getColor:(UIColor *)color withSaturation:(float)Saturation {
    //    float hsba[4];
    //    // get values
    //    [color getHue:(CGFloat *)&hsba[0] saturation:(CGFloat *)&hsba[1] brightness:(CGFloat *)&hsba[2] alpha:(CGFloat *)&hsba[3]];
    //    // return values
    //    return [UIColor colorWithHue:hsba[0] saturation:Saturation brightness:hsba[2] alpha:hsba[3]];
    //    }
    //    + (UIColor *)getColor:(UIColor *)color withScaledSaturation:(float)scale {
    //    if(scale==1.0) {
    //    return color;
    //    }
    //    if(scale<0.0){
    //    scale=0.0;
    //    }
    //    float hsba[4];
    //    // get values
    //    [color getHue:(CGFloat *)&hsba[0] saturation:(CGFloat *)&hsba[1] brightness:(CGFloat *)&hsba[2] alpha:(CGFloat *)&hsba[3]];
    //    // return values
    //    return [UIColor colorWithHue:hsba[0] saturation:hsba[1]*scale brightness:hsba[2] alpha:hsba[3]];
    //    }
    //
    //    + (UIColor *)getColor:(UIColor *)color withBrightness:(float)brightness andSaturation:(float)saturation{
    //    float hsba[4];
    //    // get values
    //    [color getHue:(CGFloat *)&hsba[0] saturation:(CGFloat *)&hsba[1] brightness:(CGFloat *)&hsba[2] alpha:(CGFloat *)&hsba[3]];
    //    // return values
    //    return [UIColor colorWithHue:hsba[0] saturation:saturation brightness:brightness alpha:hsba[3]];
    //    }
    //    + (UIColor *)getColor:(UIColor *)color withScaledBrightness:(float)bscale andScaledSaturation:(float)sscale{
    //    if(sscale==1.0&&bscale==1.0) {
    //    return color;
    //    }
    //    if(sscale<0.0){
    //    sscale=0.0;
    //    }
    //    if(bscale<0.0){
    //    sscale=0.0;
    //    }
    //
    //    float hsba[4];
    //    // get values
    //    [color getHue:(CGFloat *)&hsba[0] saturation:(CGFloat *)&hsba[1] brightness:(CGFloat *)&hsba[2] alpha:(CGFloat *)&hsba[3]];
    //    // return values
    //    return [UIColor colorWithHue:hsba[0] saturation:hsba[1]*sscale brightness:hsba[2]*bscale alpha:hsba[3]];
    //    }
    //    + (UIColor *)getColor:(UIColor *)color withHue:(float)hue {
    //    // adjust hue
    //    if (hue<0) {
    //    hue = -hue;
    //    }
    //    if(hue>1) {
    //    hue=hue/360.0;
    //    }
    //
    //    //color = [UIColor blueColor];
    //    float hsba[4];
    //    // get values
    //    [color getHue:(CGFloat *)&hsba[0] saturation:(CGFloat *)&hsba[1] brightness:(CGFloat *)&hsba[2] alpha:(CGFloat *)&hsba[3]];
    //
    //    // when the color is pure gray: saturatino is 0 set it to full saturation 1.0
    //    if(hsba[1]==0) {
    //    hsba[1]=1.0;
    //    }
    //
    //    // return values
    //    return [UIColor colorWithHue:hue saturation:hsba[1] brightness:hsba[2] alpha:hsba[3]];
    //    }
    //    + (UIColor *)mixColor:(UIColor *)color1 withColor:(UIColor *)color2 {
    //    float hsba1[4];
    //    float hsba2[4];
    //    // get values
    //    [color1 getHue:(CGFloat *)&hsba1[0] saturation:(CGFloat *)&hsba1[1] brightness:(CGFloat *)&hsba1[2] alpha:(CGFloat *)&hsba1[3]];
    //    [color2 getHue:(CGFloat *)&hsba2[0] saturation:(CGFloat *)&hsba2[1] brightness:(CGFloat *)&hsba2[2] alpha:(CGFloat *)&hsba2[3]];
    //
    //    // return values
    //    return [UIColor colorWithHue:(hsba1[0]+hsba2[0])/2.0
    //    saturation:(hsba1[1]+hsba2[1])/2.0
    //    brightness:(hsba1[2]+hsba2[2])/2.0
    //    alpha:(hsba1[3]+hsba2[3])/2.0];
    //    }
    //    + (UIColor *)getColorWithRandomHue {
    //    return [UIColor colorWithHue:((float)[CommonUtility pickRandom:360])/360.0 saturation:1.0 brightness:1.0 alpha:1.0];
    //    }
    //    // MARK: -  Date and Time Methods
    //    +(NSString *)getStringFromDate:(NSDate *)date withFormatter:(NSString *)format {
    //    // set format
    //    if(format==nil) {
    //    format=kDateFormatDefault;
    //    }
    //
    //    // get time stamp
    //    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = format;
    //    NSString *timeString = [dateFormatter stringFromDate:date];
    //    return timeString;
    //    }
    //    +(NSString *)getDateStringForNowWithFormatter:(NSString *)format {
    //    return [CommonUtility  getStringFromDate:[NSDate date] withFormatter:format];
    //    }
    //    +(NSDate *)getDateFromString:(NSString *)dateString withFormatter:(NSString *)format {
    //    // set format
    //    if(format==nil) {
    //    format=kDateFormatDefault;
    //    }
    //    // get time stamp
    //    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = format;
    //    NSDate *date = [dateFormatter dateFromString:dateString];
    //    return date;
    //    }
    //    +(NSString *)convertDateString:(NSString *)dateString withFormat:(NSString *)sformat toFormat:(NSString *)tformat {
    //    if(sformat==nil || tformat==nil) {
    //    return dateString;
    //    }
    //    // get time stamp
    //    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = sformat;
    //    NSDate *date = [dateFormatter dateFromString:dateString];
    //    dateFormatter.dateFormat = tformat;
    //    return [dateFormatter stringFromDate:date];
    //    }
    //
    //    +(NSDate *)getDateByAddingDays:(float)days toDate:(NSDate *)date {
    //    int secsInDay = 86400;
    //    return [date dateByAddingTimeInterval:days*secsInDay];
    //    }
    //
    //    +(float)numberOfDaysBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate {
    //    int secsInDay = 86400;
    //    return [endDate timeIntervalSinceDate:startDate]/secsInDay;
    //    }
    //
    //    + (NSDate *)getFirstDateOfTheYearForDate:(NSDate *)date {
    //    NSCalendar* calendar = [NSCalendar currentCalendar];
    //    // Get necessary date components
    //    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    //
    //    // set first day and month
    //    [comps setMonth:1];
    //    [comps setDay:1];
    //    return [calendar dateFromComponents:comps];
    //    }
    //    + (NSDate *)getLastDateOfTheYearForDate:(NSDate *)date {
    //    NSCalendar* calendar = [NSCalendar currentCalendar];
    //    // Get necessary date components
    //    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    //
    //    // set 0th day and month for next year
    //    [comps setYear:[comps year]+1];
    //    [comps setMonth:1];
    //    [comps setDay:0];
    //    return [calendar dateFromComponents:comps];
    //    }
    //    + (NSDate *)getFirstDateOfTheMonthForDate:(NSDate *)date {
    //    NSCalendar* calendar = [NSCalendar currentCalendar];
    //    // Get necessary date components
    //    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    //
    //    // set first day
    //    [comps setDay:1];
    //    return [calendar dateFromComponents:comps];
    //    }
    //    + (NSDate *)getLastDateOfTheMonthForDate:(NSDate *)date {
    //    NSCalendar* calendar = [NSCalendar currentCalendar];
    //    // Get necessary date components
    //    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    //
    //    // set first day and month
    //    [comps setMonth:[comps month]+1];
    //    [comps setDay:0];
    //    return [calendar dateFromComponents:comps];
    //
    //    }
    //    + (NSDate *)getFirstDateOfTheWeekForDate:(NSDate *)date {
    //    NSCalendar* calendar = [NSCalendar currentCalendar];
    //    // Get necessary date components
    //    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    //
    //    // set first day
    //    [comps setWeekday:1];
    //    return [calendar dateFromComponents:comps];
    //    }
    //    + (NSDate *)getLastDateOfTheWeekForDate:(NSDate *)date {
    //    NSCalendar* calendar = [NSCalendar currentCalendar];
    //    // Get necessary date components
    //    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    //
    //    // set 0 day and next week
    //    [comps setWeekday:7];
    //    return [calendar dateFromComponents:comps];
    //    }
    //
    //    + (NSDate *)getFirstDateOfThisYear {
    //    return [CommonUtility getFirstDateOfTheYearForDate:[NSDate date]];
    //    }
    //    + (NSDate *)getLastDateOfThisYear {
    //    return [CommonUtility getLastDateOfTheYearForDate:[NSDate date]];
    //    }
    //    + (NSDate *)getFirstDateOfThisMonth {
    //    return [CommonUtility getFirstDateOfTheMonthForDate:[NSDate date]];
    //    }
    //    + (NSDate *)getLastDateOfThisMonth {
    //    return [CommonUtility getLastDateOfTheMonthForDate:[NSDate date]];
    //    }
    //    + (NSDate *)getFirstDateOfThisWeek {
    //    return [CommonUtility getFirstDateOfTheWeekForDate:[NSDate date]];
    //    }
    //    + (NSDate *)getLastDateOfThisWeek {
    //    return [CommonUtility getLastDateOfTheWeekForDate:[NSDate date]];
    //    }
    //
    //    + (NSInteger)getCurrentYear {
    //    NSCalendar* calendar = [NSCalendar currentCalendar];
    //    // Get necessary date components
    //    NSDateComponents* comps = [calendar components:NSYearCalendarUnit fromDate:[NSDate date]];
    //    return [comps year];
    //    }
    //
    //    + (NSString *)getTimerTextFromSecs:(float)secs {
    //    int min  = (int) secs/60.0;
    //    int sec = round(secs-min*60);
    //    return [NSString stringWithFormat:@"%02d:%02d",min,sec];
    //    }
    //
    //    + (NSString *)getMinuteSecStringFromSecs:(float)secs {
    //    int min  = (int) secs/60.0;
    //    int sec = round(secs-min*60);
    //    if(min==0) {
    //    return [NSString stringWithFormat:@"%02ds",sec];
    //    }
    //    return [NSString stringWithFormat:@"%02d:%02ds",min,sec];
    //    }
    //    + (NSString *)getFullMonthNameForDate:(NSDate *)date {
    //    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"MMM";
    //    NSString *timeString = [dateFormatter stringFromDate:date];
    //    return timeString;
    //    }
    //    + (NSString *)getTimeInWordForTime:(NSString *)timeString {
    //    int valCount= (int)[[timeString componentsSeparatedByString:@":"] count];
    //    if(valCount==0) {
    //    return nil;
    //    }
    //    if(valCount==1) {
    //    int hourval = [[[timeString componentsSeparatedByString:@":"] objectAtIndex:0] intValue];
    //    return [NSString stringWithFormat:@"%@ 0'clock",[CommonUtility wordsForInt:hourval]];
    //    }
    //
    //    if(valCount>=2) {
    //    int hourval = [[[timeString componentsSeparatedByString:@":"] objectAtIndex:0] intValue];
    //    int minval = [[[timeString componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
    //    return [NSString stringWithFormat:@"%@ %@",[CommonUtility wordsForInt:hourval],(minval==0) ? @"o'clock":[CommonUtility  wordsForInt:minval]];
    //    }
    //
    //    return nil;
    //    }
    //
    //    // MARK: - NSError Generation method
    //    + (NSError *)getErrorWithDomain:(NSString *)domain
    //    code:(NSInteger)code
    //    description:(NSString *)description
    //    reason:(NSString *)reason
    //    suggestion:(NSString *)suggestion{
    //
    //    NSDictionary *userInfo = @{
    //    NSLocalizedDescriptionKey: NSLocalizedString(description, nil),
    //    NSLocalizedFailureReasonErrorKey: NSLocalizedString(reason, nil),
    //    NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(suggestion, nil)
    //    };
    //    NSError *error = [NSError errorWithDomain:domain
    //    code:code
    //    userInfo:userInfo];
    //
    //    return error;
    //    }
    //
    //    // MARK: - Image methods
    //    + (NSData *)getJPGImageDataForImage:(UIImage *)image withQuality:(float)compression {
    //    return UIImageJPEGRepresentation (image,compression);
    //    }
    //    +(UIImage *)getImageFromView:(UIView *)view {
    //    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO,0.0);
    //    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //
    //    return image;
    //    }
    //
    //    /*
    //    // MARK: - email methods
    //    + (void)addImage:(UIImage *)image asJPEGWithCompression:(float)compression andFileName:(NSString *)fileName toEmailComposer:(MFMailComposeViewController *)composer{
    //    [composer addAttachmentData:[CommonUtility getJPGImageDataForImage:image withCompression:compression] mimeType:@"image/jpeg" fileName:(fileName==nil)?@"image.jpg":fileName];
    //    }*/
    //
    //    // MARK: - currency methods
    //    + (NSString *)convertCentsToCurrencyString:(NSInteger)cents{
    //    int dollars = (int)(cents/100);
    //    cents = cents - dollars*100;
    //    if(dollars>0){
    //    return [NSString stringWithFormat:@"$%d.%02d",(int)dollars,(int)cents];
    //    }
    //    else{
    //    return [NSString stringWithFormat:@"%d¢",(int)cents];
    //    }
    //    }
    //    // MARK: - View Utility Method
    //    + (BOOL)isViewVisible:(UIViewController *)viewController{
    //    return viewController.isViewLoaded && viewController.view.window;
    //    }
    //    + (void)hideAllSubviews:(UIView *)view {
    //    for(UIView *sview in [CommonUtility listAllSubviews : view]) {
    //    sview.hidden=YES;
    //    }
    //    }
    //    + (void)unhideAllSubviews:(UIView *)view {
    //    for(UIView *sview in [CommonUtility listAllSubviews : view]) {
    //    sview.hidden=NO;
    //    }
    //    }
    //    + (NSArray *)listAllSubviews:(UIView *)view {
    //    // Array to hold the subviews
    //    NSMutableArray *marray=[[NSMutableArray alloc] init];
    //    [marray addObject:view];
    //
    //    // iterate over the view
    //    for (UIView *subview in [view subviews]) {
    //    // List the subviews of subview
    //    [marray addObjectsFromArray:[CommonUtility listAllSubviews:subview]];
    //    }
    //
    //    // return array
    //    return (NSArray *)marray;
    //    }
    //    // MARK: -  Vector print methods
    //    + (void)printIntVec:(int *)vec ofSize:(int)size {
    //    for(int ind=0; ind<size; ind++) {
    //    DBLog(@"row [%d]: %d",ind,vec[ind]);
    //    }
    //    }
    //
    //    + (void)printFloatVec:(float *)vec ofSize:(int)size {
    //    for(int ind=0; ind<size; ind++) {
    //    DBLog(@"row [%d]: %f",ind,vec[ind]);
    //    }
    //    }
    //
    //    // MARK: - C Functions
    //    double deg2rad (double degrees) {
    //    return degrees * M_PI/180;
    //    }
    
    
}
