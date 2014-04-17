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

+ (NSMutableDictionary *)createParameter
{
    return [[NSMutableDictionary alloc] initWithObjectsAndKeys: [ClientInfo getToken], @"token", nil];
}

- (id)initWithJsonDelegate:(NSString*)path params:(NSDictionary*)params delegate:(id<WHCJsonAPIDelegate>)delegate
{
    self = [super initWithHttpDelegate:[NSString stringWithFormat:@"%@.json", path]
                                params:params delegate:self];
    if(self){
        _delegate = delegate;
    }
    return self;

}
- (void)parseResponseJson
{
    hasException = YES;
 
    NSString *json = [NSString stringWithFormat:@"var result = %@", [self getResponseText]];
    JSContext *context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];

    [context evaluateScript: json];
    NSDictionary *result = [context[@"result"] toDictionary];
    code = [result getString:@"code"];
    msg = [result getString:@"msg"];
    data = [result objectForKey:@"data"];

    if ([@"0000" isEqualToString:code]){
        hasException = NO;
        return;
    } else {
        NSString *name = [NSString stringWithFormat:@"%@ %@", code, msg];
        [[BaiduMobStat defaultStat] logEvent:@"net_exception" eventLabel:name];
    }
}

- (NSArray *)getArrayData
{
    if ([data isKindOfClass:[NSArray class]]) {
        return (NSArray *)data;
    }
    return [NSArray arrayWithObject:data];
}

- (NSDictionary *)getDictionaryData
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)data;
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:data, @"data", nil];
}

- (BOOL)isSuccess
{
    return !hasException && !super.hasError;
}

- (BOOL)isAccessRefuse
{
    return [@"TokenDisableException" isEqualToString:code] || [@"TokenErrorException" isEqualToString:code];
}
- (void)onHttpRequestFinished:(WHCHttpAPI *)api
{
    if (![super hasError]) {
        [self parseResponseJson];
    }
    if ([self isSuccess]) {
        [self successJsonResult];
    } else if ([self isAccessRefuse]) {
        [self processAccessRefuse];
    } else {
        [self processFailed];
    }
    [_delegate onJsonParseFinished:self];
}

- (void)successJsonResult
{
    
}

- (void)processAccessRefuse
{
    if ([_delegate isKindOfClass:[UIViewController class]]) {
        [self showSignInView:(UIViewController*)_delegate];
        return;
    }
    if ([self isSynchronize] || ![self hasError]) {
        [self showAlert:[self getErrorMessage]];
        return;
    }
}

- (void)processFailed
{
    if ([_delegate respondsToSelector:@selector(onRequestIsFailed:)]) {
        [_delegate onRequestIsFailed:self];
        return;
    }
    if ([self isSynchronize] || ![self hasError]) {
        [self showAlert:[self getErrorMessage]];
        return;
    }
}

- (NSString *)getErrorMessage
{
    if ([super hasError]) {
        return [super getErrorMessage];
    }
    return [NSString stringWithFormat:@"%@(%@, %@)", msg, code, data];
}
#pragma mark - View Utils

- (void)synchronize
{
//    [self showProgress];
    [super synchronize];
//    sleep(10);
//    [self hideProgress];
}

- (void)showProgress
{
    UIView *view = [self getTopView];
    if (view) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:hud];
        [hud show:YES];
//        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
}

- (void)hideProgress
{
    UIView *view = [self getTopView];
    if (view) {
//        [MBProgressHUD hideHUDForView:view animated:YES];
    }
}

- (UIView *)getTopView
{
    if ([_delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)_delegate;
        if ([vc navigationController]) {
            return [[[vc navigationController] topViewController] view];
        }
        return vc.view;
    }
    return nil;
}

- (void)showSignInView:(UIViewController*)view;
{
    UIViewController *signInVc = [view.storyboard instantiateViewControllerWithIdentifier:@"SignInVC"];
    [view presentViewController:signInVc animated:YES completion:nil];
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
