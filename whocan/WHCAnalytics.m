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

static NSString * channelId = @"dev";
static NSString * netApiEvent = @"net_delay";
static NSString * netApiError = @"net_error";
static NSString * netApiException = @"net_exception";

+ (void)start
{
    BaiduMobStat * baiduStat = [BaiduMobStat defaultStat];
    baiduStat.enableExceptionLog = YES;
    baiduStat.channelId = channelId;
    baiduStat.logStrategy = BaiduMobStatLogStrategyAppLaunch;
    baiduStat.logSendInterval = 1;
    baiduStat.logSendWifiOnly = NO;
    baiduStat.sessionResumeInterval = 60;
//    statTracker.enableDebugOn = YES;
    [baiduStat startWithAppId:@"0f35e341b8"];
    
//
//    [MobClick startWithAppkey:@"5350cd0f56240bc9bc0c1e97" reportPolicy:REALTIME channelId:channelId];
    [MobClick startWithAppkey:@"5350cd0f56240bc9bc0c1e97" reportPolicy:SEND_INTERVAL channelId:channelId];
//    [MobClick setLogEnabled:YES];
}

+ (void)apiEvent:(id)api duration:(int)duration
{
    NSString * label = [[api class] description];
    [[BaiduMobStat defaultStat] logEventWithDurationTime:netApiEvent eventLabel:label durationTime:duration];
    [MobClick event:netApiEvent label:label durations:duration];
}

+ (void)apiError:(id)api message:(NSString *)message
{
    [[BaiduMobStat defaultStat] logEvent:netApiError eventLabel:message];
    [MobClick event:netApiError label:message];
}

+ (void)apiException:(id)api message:(NSString *)message
{
    [[BaiduMobStat defaultStat] logEvent:netApiException eventLabel:message];
    [MobClick event:netApiException label:message];
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
