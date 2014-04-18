//
//  WHCHttpAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCHttpAPI.h"

#define HTTP_DOMAIN @"http://www.weijinrong100.com/whocan/"

@interface WHCHttpAPI(){
    ASIFormDataRequest *_request;
    id<WHCHttpAPIDelegate> _delegate;
    BOOL _isSynchronize;
    NSDate * _beginTime;
    int _duration;
}

@end

@implementation WHCHttpAPI

@synthesize hasError;

- (id)initWithHttpDelegate:(NSString*)path params:(NSDictionary*)params delegate:(id<WHCHttpAPIDelegate>)delegate
{
    self = [super init];
    if(self){
        NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@", HTTP_DOMAIN, path]];
        _request = [ASIFormDataRequest requestWithURL:url];
        [_request setRequestMethod:@"POST"];
        [_request setDelegate:self];
        [_request setTimeOutSeconds:30];
        _delegate = delegate;
        for(NSString *key in params){
            [_request setPostValue:params[key] forKey:key];
        }
    }
    return self;
}

- (BOOL)isSynchronize
{
    return _isSynchronize;
}

- (void)synchronize
{
    _beginTime = [NSDate date];
    _isSynchronize = YES;
    [_request startSynchronous];
}

- (void)asynchronize
{
    _beginTime = [NSDate date];
    _isSynchronize = NO;
    [_request startAsynchronous];
}

- (BOOL)isSuccess
{
    return !hasError;
}

- (BOOL)hasError
{
    return [_request responseStatusCode] != 200;
}

- (int)duration
{
    return _duration;
}

- (NSString*)getErrorMessage
{
    if ([_request responseStatusMessage] != nil){
        return [_request responseStatusMessage];
    }
    if ([_request error] != nil){
        return [[_request error] localizedDescription];
    }
    return @"网络错误";
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"post url: %@", request.url);
    NSLog(@"post form: %@", [[NSString alloc] initWithData:request.postBody encoding:NSUTF8StringEncoding]);
    NSLog(@"response code %d", [request responseStatusCode]);
    [self recordErrorLog];
    _duration = [[NSDate date] timeIntervalSinceDate:_beginTime];
    [WHCAnalytics apiEvent:self duration:_duration];
    [_delegate onHttpRequestFinished:self];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self requestFinished:request];
}

- (void)recordErrorLog
{
    if (hasError) {
        NSString *message = [NSString stringWithFormat:@"%@ %d %@",
                             [self.class description],
                             [_request responseStatusCode],
                             [self getErrorMessage]];
        [WHCAnalytics apiError:self message:message];
    }
}

- (NSString *)getResponseText
{
    NSString *responseString;
    if (_request.allowCompressedResponse) {
        responseString = [[NSString alloc] initWithData:[_request responseData] encoding:NSUTF8StringEncoding];
    }else{
        responseString = [[NSString alloc] initWithData:[_request rawResponseData] encoding:NSUTF8StringEncoding];
    }
    NSLog(@"response data: %@", responseString);
    return responseString;
}

/*
- (void)requestStarted:(ASIHTTPRequest *)request
{
    
}
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    
}
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL
{
    
}
- (void)requestRedirected:(ASIHTTPRequest *)request
{
    
}
*/
@end
