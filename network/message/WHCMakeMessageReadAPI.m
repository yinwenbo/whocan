//
//  WHCMakeMessageReadAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-15.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMakeMessageReadAPI.h"

@implementation WHCMakeMessageReadAPI

@synthesize sessionId, unread;

+ (WHCMakeMessageReadAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate sessionId:(NSString *)sessionId
{
    NSString *lastMessageId = [MessageSession getLastMessage:sessionId].messageId;
    
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:lastMessageId forKey:@"readTag"];
    WHCMakeMessageReadAPI *request = [[WHCMakeMessageReadAPI alloc] initWithJsonDelegate:@"session/sendAck"
                                                                                  params:params
                                                                                delegate:delegate];
    MessageSession *session =  [MessageSession getSession:sessionId];
    [request setSessionId:sessionId];
    [request setUnread:[session.unread intValue]];
    return request;
}


- (void)successJsonResult
{
    [UIApplication sharedApplication].applicationIconBadgeNumber -= unread;
    MessageSession *session =  [MessageSession getSession:sessionId];
    session.unread = [NSNumber numberWithInteger:[session.unread intValue] - unread];
    [MessageSession saveContext];
}

@end
