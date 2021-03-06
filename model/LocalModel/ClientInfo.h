//
//  ClentInfo.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-21.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppContact.h"

@interface ClientInfo : NSObject

+ (BOOL)isSignIn;
+ (BOOL)needUpdateUserInfo;

+ (NSString *)getToken;
+ (void)cleanToken;

+ (NSString *)getDeviceToken;
+ (void)setDeviceToken:(NSString *)deviceToken;

@end
