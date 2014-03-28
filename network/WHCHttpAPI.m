//
//  WHCHttpAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCHttpAPI.h"

#define HTTP_DOMAIN @"http://www.weijinrong100.com/wei100/pm/"

@interface WHCHttpAPI(){
    ASIFormDataRequest *_request;
    id<WHCHttpAPIDelegate> _delegate;
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
        _delegate = delegate;
        NSLog(@"post url: %@", url);
        NSLog(@"post form: %@", params);
        for(NSString *key in params){
            [_request setPostValue:params[key] forKey:key];
        }
    }
    return self;
}

- (void)synchronize
{
    [_request startSynchronous];
}

- (void)asynchronize
{
    [_request startAsynchronous];
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
    self.hasError = ([_request responseStatusCode] != 200);
    [_delegate onHttpRequestFinished:self];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    self.hasError = ([_request responseStatusCode] != 200);
    [_delegate onHttpRequestFinished:self];
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
