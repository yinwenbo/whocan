//
//  WHCGetMessagesAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-1.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"

#import "MessageSession.h"

@interface WHCGetMessagesAPI : WHCJsonAPI

@property (nonatomic, retain) NSString * sessionId;

+ (WHCGetMessagesAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
                         sessionId:sessionId;

@end
