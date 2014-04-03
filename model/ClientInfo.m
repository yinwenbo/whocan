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
    return [ClientInfo getToken] != nil;
}

+ (NSString *)getToken
{
    AppContact *mine = [AppContact findMySelf];
    if (mine == nil) {
        return nil;
    }
    return mine.token;
}

+ (NSString *)getDeviceToken
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"deviceToken"];
    if (token) {
        return token;
    }
    return @"";
}

+ (void)setDeviceToken:(NSString*)deviceToken
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:deviceToken forKey:@"deviceToken"];
    [defaults synchronize];
}

@end
