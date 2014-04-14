//
//  WHCNewMessageAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-14.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCNewMessageAPI.h"

@implementation WHCNewMessageAPI

+ (WHCNewMessageAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token", nil];
    return [[WHCNewMessageAPI alloc] initWithJsonDelegate:@"session/findNewMessage"
                                                          params:params
                                                        delegate:delegate];

}

- (void)successJsonResult
{
    if ([self.data isKindOfClass:[NSNull class]]) {
        return ;
    }
    AppContact *me = [AppContact findMySelf];

    for (NSDictionary *dict in self.data[@"messages"]) {
        NSString *messageId = [self getString:dict key:@"messageId"];
        NSString *sessionId = [self getString:dict key:@"sessionId"];
        Message *message = [MessageSession getMessage:sessionId messageId:messageId];
        MessageSession *session = [MessageSession getSession:sessionId];
        if (message == nil) {
            message = [MessageSession createMessage];
            message.messageId = messageId;
            message.sessionId = sessionId;
            message.content = [self getString:dict key:@"content"];
            session.unread = [NSNumber numberWithLongLong:[session.unread longLongValue] + 1];
            session.detail = message.content;
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
        MessageUser * user = [MessageSession getUser:sessionId userId:message.senderId];
        if (user == nil){
            user = [MessageSession createUser];
            user.sessionId = sessionId;
            user.userId = senderId;
        }
    }
    [MessageSession saveContext];

}
@end
