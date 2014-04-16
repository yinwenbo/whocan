//
//  WHCNewMessageAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-14.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCNewMessageAPI.h"

#define MESSAGE_RECEIVED_NOTIFY_NAME @"MESSAGE_RECIEVED"

@implementation WHCNewMessageAPI


+ (WHCNewMessageAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
{
    return [[WHCNewMessageAPI alloc] initWithJsonDelegate:@"session/findNewMessage"
                                                   params:[WHCJsonAPI createParameter]
                                                 delegate:delegate];
}

+ (void)registerNotify:(NSObject*)observer callback:(SEL)callback
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:MESSAGE_RECEIVED_NOTIFY_NAME object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:callback
                                                 name:MESSAGE_RECEIVED_NOTIFY_NAME
                                               object:nil];
}

+ (void)removeNotify:(NSObject *)observer
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:MESSAGE_RECEIVED_NOTIFY_NAME object:nil];
}

- (void)successJsonResult
{
    NSDictionary * result = [self getDictionaryData];
    NSArray * messages = [result getArray:@"messages"];
    for (NSDictionary * dict in [result getArray:@"sessionUserInfos"]) {
        [self processSession:dict messages:messages];
    }
    [MessageSession saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_RECEIVED_NOTIFY_NAME object:nil];
}

- (void)processSession:(NSDictionary *)dict messages:(NSArray *)messages
{
    NSString *sessionId = [dict getString:@"sessionId"];
    MessageSession *session = [MessageSession getSession:sessionId];
    if (session == nil) {
        session = [MessageSession createSession];
        session.sessionId = sessionId;
    }
    session.title = [dict getString:@"sessionName"];
    NSArray * userList = [dict getArray:@"userList"];
    for (NSDictionary * user in userList) {
        AppContact * appContact = [self processUser:user];
        MessageUser * user = [MessageSession getUser:sessionId userId:appContact.appId];
        if (user == nil){
            user = [MessageSession createUser];
            user.sessionId = sessionId;
            user.userId = appContact.appId;
        }
    }
    for (NSDictionary * message in messages) {
        if ([session.sessionId isEqualToString:[message getString:@"sessionId"]]){
            [self processMessage:message session:session];
        }
    }
}

- (AppContact *)processUser:(NSDictionary *)dict
{
    NSString * userId = [dict getString:@"userId"];
    AppContact * result = [AppContact findAppContactByAppId:userId];
    if (result == nil) {
        result = [AppContact createAppContact];
        result.appId = userId;
    }
    result.appName = [dict getString:@"userName"];
    result.gender = [dict getString:@"gender"];
    result.icon = [dict getString:@"portrait"];
    return result;
}

- (void)processMessage:(NSDictionary *)dict session:(MessageSession *)session
{
    NSString *messageId = [dict getString:@"messageId"];
    NSString *sessionId = session.sessionId;
    Message *message = [MessageSession getMessage:sessionId messageId:messageId];
    if (message == nil) {
        message = [MessageSession createMessage];
        message.messageId = messageId;
        message.sessionId = sessionId;
        message.content = [dict getString:@"content"];
        message.senderId = [dict getString:@"fromUser"];
        message.type = [dict getString:@"msgType"];
        session.unread = [NSNumber numberWithLongLong:[session.unread longLongValue] + 1];
        session.lastupdate = [dict getDate:@"createTime"];
    }
    if ([message isSendFailed] || [message isSending]) {
        [message setStatusToSuccess];
    }
    if (message.time == nil){
        message.time = [dict getDate:@"createTime"];
    }
}

@end
