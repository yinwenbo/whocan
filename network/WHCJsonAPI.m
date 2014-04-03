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
    code = [result objectForKey:@"code"];
    msg = [result objectForKey:@"msg"];
    data = [result objectForKey:@"data"];
    
    if ([@"0000" isEqualToString:code]){
        hasException = NO;
        return;
    }
}

- (BOOL)isSuccess
{
    return !hasException && !super.hasError;
}

- (BOOL)isAccessRefuse
{
    return [@"TokenDisableException" isEqualToString:code];
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
    } else {
        [self showAlert:@"登录超时"];
    }
}

- (void)processFailed
{
    if ([_delegate respondsToSelector:@selector(onRequestIsFailed:)]) {
        [_delegate onRequestIsFailed:self];
    }else {
        [self showAlert:[self getErrorMessage]];
    }
}

- (NSString *)getErrorMessage
{
    if ([super hasError]) {
        return [super getErrorMessage];
    }
    return [NSString stringWithFormat:@"%@(%@)", msg, code];
}

#pragma mark - Utils Method

- (NSDate *)getDate:(NSString *)key
{
    return [self getDate:self.data key:key];
}

- (NSDate *)getDate:(NSDictionary*)dict key:(NSString*)key
{
    NSString *value = [self getString:dict key:key];
    NSDate *result = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]/1000];
    /*
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"'公元前/后:'G  '年份:'u'='yyyy'='yy '季度:'q'='qqq'='qqqq '月份:'M'='MMM'='MMMM '今天是今年第几周:'w '今天是本月第几周:'W  '今天是今天第几天:'D '今天是本月第几天:'d '星期:'c'='ccc'='cccc '上午/下午:'a '小时:'h'='H '分钟:'m '秒:'s '毫秒:'SSS  '这一天已过多少毫秒:'A  '时区名称:'zzzz'='vvvv '时区编号:'Z "];
    NSLog(@"%@", [dateFormatter stringFromDate:result]);
    */
    return result;
}

- (NSString *)getString:(NSString *)key
{
    return [self getString:self.data key:key];
}

- (NSString *)getString:(NSDictionary*)dict key:(NSString*)key
{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id result = [dict objectForKey:key];
    if (result == nil){
        return nil;
    }
    if ([result isKindOfClass:[NSNull class]]){
        return @"";
    }
    if ([result isKindOfClass:[NSString class]]){
        return (NSString*)result;
    }
    return [result stringValue];
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
