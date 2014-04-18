//
//  WHCAnalytics.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCAnalytics.h"

#import "BaiduMobStat.h"

@implementation WHCAnalytics

+ (void)start
{
    BaiduMobStat * statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = YES;
    statTracker.channelId = @"dev";
    statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch;
    statTracker.logSendInterval = 1;
    statTracker.logSendWifiOnly = NO;
    statTracker.sessionResumeInterval = 60;
    statTracker.enableDebugOn = YES;
    [statTracker startWithAppId:@"0f35e341b8"];
}

+ (void)startApi:(id)api
{
    [[BaiduMobStat defaultStat] eventStart:@"net_delay" eventLabel:[[api class] description]];
}

+ (void)endApi:(id)api
{
    [[BaiduMobStat defaultStat] eventEnd:@"net_delay" eventLabel:[[api class] description]];
}

+ (void)apiError:(id)api message:(NSString *)message
{
    [[BaiduMobStat defaultStat] logEvent:@"net_error" eventLabel:message];
}

+ (void)apiException:(id)api message:(NSString *)message
{
    [[BaiduMobStat defaultStat] logEvent:@"net_exception" eventLabel:message];
}

+ (void)viewIn:(id)view
{
    [[BaiduMobStat defaultStat] pageviewStartWithName:[[view class] description]];
}

+ (void)viewOut:(id)view
{
    [[BaiduMobStat defaultStat] pageviewEndWithName:[[view class] description]];
}

@end
