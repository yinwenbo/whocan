//
//  HttpJsonAPI.m
//
//  Created by Yin Wenbo on 14-5-6.
//  Copyright (c) 2014年 jh. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>

#import "HttpJsonAPI.h"
#import "ASIFormDataRequest.h"
#import "ClientInfo.h"

@interface HttpJsonAPI() {
    ASIFormDataRequest * _request;
    id<HttpJsonAPIDelegate> _delegate;
    
    NSString * _url;
    NSDictionary * _params;
    JsonAPIResult * _result;
    BOOL _isSynchronize;
    
    CallbackBlock _onFinishedBlock;
    UIView * _progressBaseView;
    
    NSString * _errorMessage;
}
@end

@implementation HttpJsonAPI

+ (HttpJsonAPI *)getInstance:(id<HttpJsonAPIDelegate>)delegate params:(NSDictionary *)params url:(NSString *)url
{
    return [[HttpJsonAPI alloc] initWithDelegate:delegate params:params url:url];
}

+ (NSMutableDictionary *)paramsWithToken
{
    return [[NSMutableDictionary alloc] initWithObjectsAndKeys: [ClientInfo getToken], @"token", nil];
}


- (id)initWithDelegate:(id<HttpJsonAPIDelegate>)delegate
                params:(NSDictionary *)params
                   url:(NSString *)url
{
    self = [super init];
    if (self) {
        _params = params;
        _delegate = delegate;
        _url = url;
    }
    return self;
}

- (id)initWithParams:(NSDictionary *)params
                 url:(NSString *)url
{
    self = [super init];
    if (self) {
        _params = params;
        _url = url;
    }
    return self;
}


- (void)startAsynchronize
{
    [self createRequest];
    _isSynchronize = NO;
    [_request startAsynchronous];
}

- (void)startAsynchronize:(CallbackBlock)onFinished showProgressOn:(UIView *)view
{
    _onFinishedBlock = onFinished;
    _progressBaseView = view;
    [self startAsynchronize];
}

- (void)startSynchronize
{
    [self createRequest];
    _isSynchronize = YES;
    [_request startSynchronous];
}

- (void)startSynchronize:(CallbackBlock)onFinished showProgressOn:(UIView *)view
{
    _onFinishedBlock = onFinished;
    _progressBaseView = view;
    [self startSynchronize];
}

- (void)cancelRequest
{
    debugLog(@"cancel request %@", _url);
    [_request clearDelegatesAndCancel];
}

- (BOOL)isMatchUrl:(NSString *)url
{
    return [_url isEqualToString:url];
}

- (JsonAPIResult *)getResult
{
    return _result;
}

- (void)createRequest
{
    _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:_url]];
    [_request setRequestMethod:@"POST"];
    [_request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [_request addRequestHeader:@"Accept" value:@"application/json"];
    [_request setDelegate:self];
    for(NSString *key in _params){
        [_request setPostValue:_params[key] forKey:key];
    }
    
}

- (void)processResonse:(ASIHTTPRequest *)request
{
    NSData *responseData;
    if (_request.allowCompressedResponse) {
        responseData = [_request responseData];
    }else{
        responseData = [_request rawResponseData];
    }
    _result = [JsonAPIResult resultWithJsonData:responseData];
    
    debugLog(@"request %@", _url);
    debugLog(@"params %@", _params);
    debugLog(@"post body %@", [NSString stringWithUTF8String: [_request.postBody bytes]]);
    debugLog(@"response %@", [NSString stringWithUTF8String: [responseData bytes]]);
    if (_onFinishedBlock) {
        _onFinishedBlock(self);
    }
//    [_delegate onJsonParseFinished:self];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self processResonse:request];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self processResonse:request];
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