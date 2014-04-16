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
    message.senderId = [AppContact findMySelf].appId;
    [message setStatusToSending];
    [MessageSession saveContext];
    
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:message.sessionId forKey:@"sessionId"];
    [params setObject:message.messageId forKey:@"messageId"];
    [params setObject:message.content forKey:@"content"];
        
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
