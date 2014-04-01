//
//  WHCAllMessageSessionAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-31.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCAllMessageSessionAPI.h"

@implementation WHCAllMessageSessionAPI

+ (WHCAllMessageSessionAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token", nil];
    return [[WHCAllMessageSessionAPI alloc] initWithJsonDelegate:@"session/findAll"
                                                    params:params
                                                  delegate:delegate];
}

- (void)successJsonResult
{
    if ([self.data isKindOfClass:[NSNull class]]) {
        return;
    }
    for (NSDictionary *dict in self.data){
        NSString *sessionId = [self getString:dict key:@"sessionId"];
        MessageSession * session = [MessageSession getSession:sessionId];
        if (session == nil) {
            session = [MessageSession createSession];
            session.sessionId = sessionId;
        }
        session.title = [self getString:dict key:@"sessionName"];
        
        for (NSDictionary *userDict in [dict objectForKey:@"userList"]) {
            NSString *userId = [self getString:userDict key:@"userId"];
            MessageUser *user = [MessageSession getUser:sessionId userId:userId];
            if (user == nil) {
                user = [MessageSession createUser];
                user.userId = userId;
            }
            user.userName = [self getString:userDict key:@"userName"];
        }
    }
    [MessageSession saveContext];
}
@end
