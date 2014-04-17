//
//  WHCAppDelegate.m
//  whocan
//
//  Created by Yin Wenbo on 14-2-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCAppDelegate.h"

#import "WHCNewMessageAPI.h"

#import "BaiduMobStat.h"

@interface WHCAppDelegate()

@end

@implementation WHCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AddressBookUtil hasPermission];
    [AppContact exportPhoneABToAppContacts];
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
    BaiduMobStat * statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = YES;
    statTracker.channelId = @"dev";
    statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch;
    statTracker.logSendInterval = 1;
    statTracker.logSendWifiOnly = NO;
    statTracker.sessionResumeInterval = 60;
    statTracker.enableDebugOn = YES;
    [statTracker startWithAppId:@"0f35e341b8"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *tokenDesc = [deviceToken description];
    NSMutableString *token =[NSMutableString stringWithString:tokenDesc];
    [ClientInfo setDeviceToken:[token stringByReplacingOccurrencesOfString:@"[<>\\s]"
                                                                withString:@""
                                                                   options:NSRegularExpressionSearch
                                                                     range:(NSRange){0, tokenDesc.length}]];
    NSLog(@"registe success: %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"registe fail: %@", error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:10];
    [[WHCNewMessageAPI getInstance:nil] asynchronize];
    NSLog(@"receive : %@", userInfo);
}

@end
