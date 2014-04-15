//
//  WHCNewMessageAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-14.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"

#import "ClientInfo.h"
#import "MessageSession.h"

@interface WHCNewMessageAPI : WHCJsonAPI

+ (WHCNewMessageAPI*)getInstance:(id<WHCJsonAPIDelegate>)delegate;

+ (void)registerNotify:(NSObject*)observer callback:(SEL)callback;
+ (void)removeNotify:(NSObject *)observer;

@end
