//
//  BSRSpeechRecognizerError.h
//  DeepSpeechBaseKit
//
//  Created by Thuan Nguyen on 11/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

/*!
 @typedef BSRSpeechRecognizerError

 @brief List of possible error codes during transcription

 @field BSRSpeechRecognizerErrorNone Uninitialized error
 @field BSRSpeechRecognizerErrorAudio Audio recording error
 @field BSRSpeechRecognizerErrorClient Other client side errors
 @field BSRSpeechRecognizerErrorInsufficientPermissions Insufficient permissions
 @field BSRSpeechRecognizerErrorNetwork Other network related errors
 @field BSRSpeechRecognizerErrorNetworkTimeout Network operation timed out
 @field BSRSpeechRecognizerErrorNoMatch No recognition result matched
 @field BSRSpeechRecognizerErrorRecognizerBusy Recognizer is busy
 @field BSRSpeechRecognizerErrorServer Server sends error status
 @field BSRSpeechRecognizerErrorSpeechTimeout No speech input

 */

typedef NS_ENUM(NSInteger, BSRSpeechRecognizerError) {
    BSRSpeechRecognizerErrorNone = 0,
    BSRSpeechRecognizerErrorAudio,
    BSRSpeechRecognizerErrorClient,
    BSRSpeechRecognizerErrorInsufficientPermissions,
    BSRSpeechRecognizerErrorNetwork,
    BSRSpeechRecognizerErrorNetworkTimeout,
    BSRSpeechRecognizerErrorNoMatch,
    BSRSpeechRecognizerErrorRecognizerBusy,
    BSRSpeechRecognizerErrorServer,
    BSRSpeechRecognizerErrorSpeechTimeout
};