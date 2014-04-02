//
//  ClentInfo.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-21.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "ClientInfo.h"

@implementation ClientInfo


+ (BOOL)isSignIn
{
    return [self getToken] != nil && [AppContact findMySelf] != nil;
}

+ (NSString *)getToken
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"token"];
}

+ (void)setToken:(NSString *)token
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"token"];
    [defaults synchronize];
}

+ (NSString *)getDeviceToken
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"deviceToken"];

}
+ (void)setDeviceToken:(NSString*)deviceToken
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:deviceToken forKey:@"deviceToken"];
    [defaults synchronize];
}

@end
