//
//  WHCMakeMessageReadAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-15.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"

#import "MessageSession.h"

@interface WHCMakeMessageReadAPI : WHCJsonAPI

+ (WHCMakeMessageReadAPI*)getInstance:(id<WHCJsonAPIDelegate>)delegate
                        sessionId:(NSString *)sessionId;

@property (nonatomic, retain) NSString * sessionId;
@property (nonatomic) int unread;

@end
