//
//  WHCGetMessageSessionAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-28.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"

#import "MessageSession.h"

@interface WHCGetMessageSessionAPI : WHCJsonAPI

@property (nonatomic, retain) NSString * sessionId;
@property (nonatomic, retain) NSString * title;

+ (WHCGetMessageSessionAPI*)getInstance:(id<WHCJsonAPIDelegate>)delegate toUserId:(NSString*)toUserId;

@end
