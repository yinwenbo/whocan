//
//  WHCGetMessagesAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-1.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCGetMessagesAPI.h"

@implementation WHCGetMessagesAPI

@synthesize sessionId;

+ (WHCGetMessagesAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate sessionId:(id)sessionId
{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token",
                            sessionId, @"sessionId", nil];
    WHCGetMessagesAPI *result = [[WHCGetMessagesAPI alloc] initWithJsonDelegate:@"session/findMessage"
                                                                         params:params
                                                                       delegate:delegate];
    result.sessionId = sessionId;
    return result;
}

- (void)successJsonResult
{
    if ([self.data isKindOfClass:[NSNull class]]) {
        return ;
    }
    for (NSDictionary *dict in self.data) {
        NSString *messageId = [self getString:dict key:@"messageId"];
        Message *message = [MessageSession getMessage:self.sessionId messageId:messageId];
        if (message == nil) {
            message = [MessageSession createMessage];
            message.messageId = messageId;
            message.sessionId = self.sessionId;
            message.content = [self getString:dict key:@"content"];
            message.senderId = [self getString:dict key:@"userId"];
        } else if (![message.status isEqualToString:MESSAGE_STATUS_SUCCESS]) {
            message.status = MESSAGE_STATUS_SUCCESS;
        }
    }
    [MessageSession saveContext];
}
@end
