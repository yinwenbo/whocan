//
//  WHCAnalytics.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHCAnalytics : NSObject

+ (void)start;

+ (void)startApi:(id)api;
+ (void)endApi:(id)api;

+ (void)apiError:(id)api message:(NSString *)message;
+ (void)apiException:(id)api message:(NSString *)message;

+ (void)viewIn:(id)view;
+ (void)viewOut:(id)view;
@end
