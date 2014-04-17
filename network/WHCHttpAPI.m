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
    _isSynchronize = YES;
    [[BaiduMobStat defaultStat] eventStart:@"net_delay" eventLabel:[[self class] description]];
    [_request startSynchronous];
}

- (void)asynchronize
{
    [[BaiduMobStat defaultStat] eventStart:@"net_delay" eventLabel:[[self class] description]];
    [_request startAsynchronous];
}

- (BOOL)isSuccess
{
    return !hasError;
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
    [[BaiduMobStat defaultStat] eventEnd:@"net_delay" eventLabel:[[self class] description]];
    NSLog(@"post url: %@", request.url);
    NSLog(@"post form: %@", [[NSString alloc] initWithData:request.postBody encoding:NSUTF8StringEncoding]);
    NSLog(@"response code %d", [request responseStatusCode]);
    self.hasError = ([_request responseStatusCode] != 200);
    [_delegate onHttpRequestFinished:self];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [[BaiduMobStat defaultStat] eventEnd:@"net_delay" eventLabel:[[self class] description]];
    self.hasError = ([_request responseStatusCode] != 200);
    [_delegate onHttpRequestFinished:self];
}

- (void)recordErrorLog
{
    if (hasError) {
        NSString *name = [NSString stringWithFormat:@"%@ %d %@",
                          [[self class] description],
                          [_request responseStatusCode],
                          [self getErrorMessage]];
        [[BaiduMobStat defaultStat] logEvent:@"net_error" eventLabel:name];
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
