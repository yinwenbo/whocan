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
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:sessionId forKey:sessionId];
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
    for (NSDictionary *dict in [self getDictionaryData]) {
        NSString *messageId = [dict getString:@"messageId"];
        Message *message = [MessageSession getMessage:self.sessionId messageId:messageId];
        if (message == nil) {
            message = [MessageSession createMessage];
            message.messageId = messageId;
            message.sessionId = self.sessionId;
            message.content = [dict getString:@"content"];
            unread++;
        }
        NSString *senderId = [dict getString:@"userId"];
        if ([senderId isEqualToString:me.appId]) {
            [message setSenderIsMe];
        } else if (message.senderId == nil) {
            message.senderId = senderId;
        }

        if ([message isSendFailed] || [message isSending]) {
            [message setStatusToSuccess];
        }
        if (message.time == nil){
            message.time = [dict getDate:@"createTime"];
        }
    }
    [MessageSession saveContext];
}
@end
