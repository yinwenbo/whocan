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
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token", nil];
    return [[WHCNewMessageAPI alloc] initWithJsonDelegate:@"session/findNewMessage"
                                                          params:params
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
    if ([self.data isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    for (NSDictionary * dict in self.data[@"sessionUserInfos"]) {
        [self processSession:dict messages:self.data[@"messages"]];
    }
    [MessageSession saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_RECEIVED_NOTIFY_NAME object:nil];
}

- (void)processSession:(NSDictionary *)dict messages:(NSArray *)messages
{
    NSString *sessionId = [self getString:dict key:@"sessionId"];
    MessageSession *session = [MessageSession getSession:sessionId];
    if (session == nil) {
        session = [MessageSession createSession];
        session.sessionId = sessionId;
    }
    session.title = [self getString:dict key:@"sessionName"];
    NSArray * userList = dict[@"userList"];
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
        if ([session.sessionId isEqualToString:[self getString:message key:@"sessionId"]]){
            [self processMessage:message session:session];
        }
    }
}

- (AppContact *)processUser:(NSDictionary *)dict
{
    NSString * userId = [self getString:dict key:@"userId"];
    AppContact * result = [AppContact findAppContactByAppId:userId];
    if (result == nil) {
        result = [AppContact createAppContact];
        result.appId = userId;
    }
    result.appName = [self getString:dict key:@"userName"];
    result.gender = [self getString:dict key:@"gender"];
    result.icon = [self getString:dict key:@"portrait"];
    return result;
}

- (void)processMessage:(NSDictionary *)dict session:(MessageSession *)session
{
    NSString *messageId = [self getString:dict key:@"messageId"];
    NSString *sessionId = session.sessionId;
    Message *message = [MessageSession getMessage:sessionId messageId:messageId];
    if (message == nil) {
        message = [MessageSession createMessage];
        message.messageId = messageId;
        message.sessionId = sessionId;
        message.content = [self getString:dict key:@"content"];
        message.senderId = [self getString:dict key:@"userId"];
        session.unread = [NSNumber numberWithLongLong:[session.unread longLongValue] + 1];
        session.lastupdate = [self getDate:dict key:@"createTime"];
    }
    if ([message isSendFailed] || [message isSending]) {
        [message setStatusToSuccess];
    }
    if (message.time == nil){
        message.time = [self getDate:dict key:@"createTime"];
    }

}

@end
