//
//  WHCHttpAPIDelegate.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WHCJsonAPI(){
    id<WHCJsonAPIDelegate> _delegate;
}

@end
@implementation WHCJsonAPI

@synthesize code, msg, data, hasException;

- (id)initWithJsonDelegate:(NSString*)path params:(NSDictionary*)params delegate:(id<WHCJsonAPIDelegate>)delegate
{
    self = [super initWithHttpDelegate:path params:params delegate:self];
    if(self){
        _delegate = delegate;
    }
    return self;

}
- (void)parseResponseJson
{
    hasException = YES;
    if ([self hasError]){
        [self showAlert:[self getErrorMessage]];
        return;
    }

    NSString *json = [NSString stringWithFormat:@"var result = %@", [self getResponseText]];
    JSContext *context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];

    [context evaluateScript: json];
    NSDictionary *result = [context[@"result"] toDictionary];
    code = [result objectForKey:@"code"];
    msg = [result objectForKey:@"msg"];
    data = [result objectForKey:@"data"];
    
    if ([@"0000" isEqualToString:code]){
        hasException = NO;
        return;
    }
    if ([@"TokenDisableException" isEqualToString:code]) {
        [self showSignInView];
        return;
    }
    [self showAlert:[NSString stringWithFormat:@"%@(%@)", msg, code]];
}

- (void)onHttpRequestFinished:(WHCHttpAPI *)api
{
    [self parseResponseJson];
    [self doDelegate];
}

- (void)doDelegate
{
    [_delegate onJsonParseFinished:self];
}

- (NSString*)getString:(NSString *)key
{
    return [self.data objectForKey:key];
}

- (void)showSignInView
{
    if([_delegate isKindOfClass:[UIViewController class]]){
        UIViewController *vc = (UIViewController*)_delegate;
        UIViewController *signInVc = [vc.storyboard instantiateViewControllerWithIdentifier:@"SignInVC"];
        [vc presentViewController:signInVc animated:YES completion:nil];
    }
}

- (void)showAlert:(NSString*)message
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"联网失败"
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
@end
