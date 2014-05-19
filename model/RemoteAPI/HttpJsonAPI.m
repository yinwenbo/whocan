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
#import "MBProgressHUD.h"


@interface HttpJsonAPI() {
    ASIFormDataRequest * _request;
    id<HttpJsonAPIDelegate> _delegate;
    NSData * _responseData;
    
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
    [self beforeStart];
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
    [self beforeStart];
    _isSynchronize = YES;
    [_request startSynchronous];
}

- (void)startSynchronizeWithFinishedBlock:(CallbackBlock)onFinished showProgressOn:(UIView *)view
{
    _onFinishedBlock = onFinished;
    _progressBaseView = view;
    [self startSynchronize];
}

- (void)beforeStart
{
    if (_progressBaseView) {
        [MBProgressHUD showHUDAddedTo:_progressBaseView animated:YES];
    }
    [self createRequest];
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

- (void)cancelRequest
{
    debugLog(@"cancel request %@", _url);
    [_request clearDelegatesAndCancel];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self afterResponse];
    [self processSuccess];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self afterResponse];
    [self processFailed];
}

- (void)afterResponse
{
    if (_request.allowCompressedResponse) {
        _responseData = [_request responseData];
    }else{
        _responseData = [_request rawResponseData];
    }
    if (_progressBaseView) {
        [MBProgressHUD hideHUDForView:_progressBaseView animated:YES];
    }
    debugLog(@"request %@", _url);
    debugLog(@"params %@", _params);
    debugLog(@"post body %@", [NSString stringWithUTF8String: [_request.postBody bytes]]);
    debugLog(@"response %@", [NSString stringWithUTF8String: [_responseData bytes]]);
}

- (void)processSuccess
{
    _result = [JsonAPIResult resultWithJsonData:_responseData];
    if (_onFinishedBlock) {
        _onFinishedBlock(self);
    }
}

- (void)processFailed
{
    NSString *message = [NSString stringWithFormat:@"%@ %d %@",
                         [self apiUrlShortName],
                         [_request responseStatusCode],
                         [self getErrorMessage]];
    [WHCAnalytics apiError:self message:message];
    if (_onFinishedBlock) {
        _onFinishedBlock(self);
    }
}

- (BOOL)isMatchUrl:(NSString *)url
{
    return [_url isEqualToString:url];
}

- (JsonAPIResult *)getResult
{
    return _result;
}

- (BOOL)isSuccess
{
    return [_request responseStatusCode] == 200;
}

- (NSString *)getErrorMessage
{
    if ([_request responseStatusMessage] != nil){
        return [_request responseStatusMessage];
    }
    if ([_request error] != nil){
        return [[_request error] localizedDescription];
    }
    return @"网络错误";    
}

- (NSString *)apiUrlShortName
{
    return [_url substringFromIndex:[api_host length]];
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