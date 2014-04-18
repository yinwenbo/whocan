//
//  WHCAnalytics.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCAnalytics.h"

#import "BaiduMobStat.h"
#import "MobClick.h"

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
    
//
    [MobClick startWithAppkey:@"5350cd0f56240bc9bc0c1e97" reportPolicy:SEND_INTERVAL channelId:@"dev"];

}

+ (void)startApi:(id)api
{
    NSString * event = @"net_delay";
    NSString * label = [[api class] description];
    [[BaiduMobStat defaultStat] eventStart:event eventLabel:label];
    [MobClick beginEvent:event label:label];
}

+ (void)endApi:(id)api
{
    NSString * event = @"net_delay";
    NSString * label = [[api class] description];
    [[BaiduMobStat defaultStat] eventEnd:event eventLabel:label];
    [MobClick endEvent:event label:label];
}

+ (void)apiError:(id)api message:(NSString *)message
{
    NSString * event = @"net_error";
    [[BaiduMobStat defaultStat] logEvent:event eventLabel:message];
    [MobClick event:event label:message];
}

+ (void)apiException:(id)api message:(NSString *)message
{
    NSString * event = @"net_exception";
    [[BaiduMobStat defaultStat] logEvent:event eventLabel:message];
    [MobClick event:event label:message];
}

+ (void)viewIn:(id)view
{
    NSString * viewName = [[view class] description];
    [[BaiduMobStat defaultStat] pageviewStartWithName:viewName];
    [MobClick beginLogPageView:viewName];
}

+ (void)viewOut:(id)view
{
    NSString * viewName = [[view class] description];
    [[BaiduMobStat defaultStat] pageviewEndWithName:viewName];
    [MobClick endLogPageView:viewName];
}

@end
