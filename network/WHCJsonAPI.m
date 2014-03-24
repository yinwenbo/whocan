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
    id<WHCHttpAPIDelegate> _delegate;
}

@end

@implementation WHCJsonAPI

@synthesize code, msg, data;

- (id)init:(NSString *)path params:(NSDictionary *)params delegate:(id<WHCHttpAPIDelegate>)delegate
{
    _delegate = delegate;
    return [super init:path params:params delegate:self];
}

- (void)parseResponseJson
{
    NSString *json = [NSString stringWithFormat:@"var result = %@", [self getResponseText]];
    NSLog(@"%@", json);
    JSContext *context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];

    [context evaluateScript: json];
    NSDictionary *result = [context[@"result"] toDictionary];
    code = [result objectForKey:@"code"];
    msg = [result objectForKey:@"msg"];
    data = [result objectForKey:@"data"];
}

- (void)onFinished:(WHCHttpAPI *)api
{
    [self parseResponseJson];
    if ([@"TokenDisableException" isEqualToString:code]) {
        if([_delegate isKindOfClass:[UIViewController class]]){
            UIViewController *vc = (UIViewController*)_delegate;
            UIViewController *signInVc = [vc.storyboard instantiateViewControllerWithIdentifier:@"SignInVC"];
            [vc presentViewController:signInVc animated:YES completion:nil];
        }
        return;
    }
    [_delegate onFinished:api];
}

- (NSString*)getString:(NSString *)key
{
    return [self.data objectForKey:key];
}
@end
