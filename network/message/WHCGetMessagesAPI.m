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
    AppContact *me = [AppContact findMySelf];
    NSInteger unread = 0;
    for (NSDictionary *dict in self.data) {
        NSString *messageId = [self getString:dict key:@"messageId"];
        Message *message = [MessageSession getMessage:self.sessionId messageId:messageId];
        if (message == nil) {
            message = [MessageSession createMessage];
            message.messageId = messageId;
            message.sessionId = self.sessionId;
            message.content = [self getString:dict key:@"content"];
            unread++;
        }
        NSString *senderId = [self getString:dict key:@"userId"];
        if ([senderId isEqualToString:me.appId]) {
            [message setSenderIsMe];
        } else if (message.senderId == nil) {
            message.senderId = senderId;
        }

        if ([message isSendFailed] || [message isSending]) {
            [message setStatusToSuccess];
        }
        if (message.time == nil){
            message.time = [self getDate:dict key:@"createTime"];
        }
    }
    [MessageSession saveContext];
}
@end
