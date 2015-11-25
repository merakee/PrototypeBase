//
//  BSRBatchAPI.m
//  DemoV2
//
//  Created by Kenny Liou on 10/23/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "ASRBatchAPI.h"
//#import "SoundFileHelper.h"
//#import "DemoHelper.h"

@interface ASRBatchAPI()

@property (strong, nonatomic) NSOperationQueue * queue;
@property (strong, nonatomic) BSRApiConfig * apiConfig;
@property (strong, nonatomic) NSURLRequest * urlRequest;
@property (strong, nonatomic) NSURLSession * urlSession;

@end

@implementation ASRBatchAPI

+ (instancetype) sharedInstance
{
    static ASRBatchAPI * api = NULL;
    if (!api) {
        api = [[ASRBatchAPI alloc] init];
    }
    
    return api;
}

- (void) setServerSetting:(BSRApiConfig *)apiConfig
{
    _apiConfig = apiConfig;
    [self setQueue:NULL];
    [self setUrlRequest:NULL];
}

- (void) sendData:(NSData *) data isLast:(BOOL)isLast sampleRate:(BSRSampleRate) rate
{
    // ignore
}

- (void) sendData:(NSData *) data
{
    NSArray * params = @[self.urlRequest, data];
    NSInvocationOperation * operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(sendDataWithRequest:) object:params];
    
    [self.queue addOperation:operation];
}

- (void) sendDataWithRequest:(NSArray *) params
{
    NSURLRequest * request = [params objectAtIndex:0];
    NSData * data = [params objectAtIndex:1];
    
    [self addLog:[NSString stringWithFormat:@"--batch request len: %lu", (unsigned long)[data length]]];
    
    [[self.urlSession uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"ERROR %@", error);
        } else {
            NSString *transcription = nil;
            NSError * e;
            
            NSData *jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&e];
            
            if (e) {
                NSLog(@"Error: %@, with response data: %@", e, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            } else {
                [self addLog:[NSString stringWithFormat:@"Received json: %@\n", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]]];
            }
            
            NSDictionary * result = (NSDictionary *) jsonData;
            
            transcription = [result objectForKey:@"result"];
            
            NSString * error = [result objectForKey:@"error"];
            
            if (self.delegate != NULL) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSError *responseError = nil;
                    if (error && [error length] > 0) {
                        NSLog(@"Error: %@", error);
                        responseError = [NSError errorWithDomain:@"com.baidu.transcription" code:BSRSpeechRecognizerErrorServer userInfo:@{NSLocalizedDescriptionKey: error}];
                    }
                    
                    BSRTranscriptionResult *transcriptionResult = [[BSRTranscriptionResult alloc] init];
                    if (transcription != nil) {
                        BSRTranscription *t = [[BSRTranscription alloc] init];
                        t.transcription = transcription;
                        transcriptionResult.transcriptions = @[t];
                    }
                    
                    [self.delegate server:self didReceiveTranscription:transcriptionResult utteranceEnd:YES error:responseError];
                });
            }
        }
    }] resume];
}

- (NSOperationQueue *) queue
{
    if (!_queue) {
        
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:[[self.apiConfig maxConcurrency] integerValue]];
    }
    
    return _queue;
}

- (NSURLRequest *) urlRequest
{
    if (!_urlRequest) {
        
        NSString * endPoint = [[self.apiConfig streamingEndpointURL] absoluteString];
        float timeout = [[self.apiConfig defaultTimeout] floatValue];

        NSMutableURLRequest * mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:endPoint]
                                                                 cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                             timeoutInterval:timeout];
        [mRequest setHTTPMethod:@"POST"];
        [mRequest setValue:@"audio/wav" forHTTPHeaderField:@"Content-Type"];
        [mRequest setValue:@"Bearer dh1tQD2LBm95kw2uoSRAFQ==" forHTTPHeaderField:@"Authorization"];
        
        _urlRequest = mRequest;
    }
    
    return _urlRequest;
}

- (NSURLSession *) urlSession
{
    if (!_urlSession) {
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setRequestCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];

        _urlSession = [NSURLSession sessionWithConfiguration:config];
    }
    
    return _urlSession;
}

-(void) addLog:(NSString*)log
{
    dispatch_async (dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ASRLOG" object:log];
    });
}

@end
