//
//  WHCSendMessageAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-31.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSendMessageAPI.h"

@implementation WHCSendMessageAPI

@synthesize message;

+ (WHCSendMessageAPI*)getInstance:(id<WHCJsonAPIDelegate>)delegate
                        sessionId:(NSString*)sessionId
                          content:(NSString*)content {
    Message *message = [MessageSession createMessage];
    message.sessionId = sessionId;
    message.content = content;
    message.messageId = [[[NSUUID alloc] init] UUIDString];
    [message setSenderIsMe];
    [message setStatusToSending];
    [MessageSession saveContext];
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token",
                            message.sessionId, @"sessionId",
                            message.messageId, @"messageId",
                            message.content, @"content", nil];
    
    WHCSendMessageAPI *result = [[WHCSendMessageAPI alloc] initWithJsonDelegate:@"session/sendMessage"
                                                                         params:params
                                                                        delegate:delegate];
    result.message = message;
    return result;
}

- (void)successJsonResult
{
    [self.message setStatusToSuccess];
    [MessageSession saveContext];
}

@end
