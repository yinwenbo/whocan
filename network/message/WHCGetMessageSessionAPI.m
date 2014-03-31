//
//  WHCGetMessageSessionAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-28.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCGetMessageSessionAPI.h"

@implementation WHCGetMessageSessionAPI

@synthesize sessionId, title;

+ (WHCGetMessageSessionAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate toUserId:(NSString *)toUserId
{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token",
                            toUserId, @"friendId", nil];
    return [[WHCGetMessageSessionAPI alloc] initWithJsonDelegate:@"session/findPrivate"
                                                   params:params
                                                 delegate:delegate];
}

- (void)successJsonResult
{
    self.sessionId = [self getString:@"sessionId"];
    self.title = [self getString:@"sessionName"];
    MessageSession *session = [MessageSession createSession];
    session.sessionId = self.sessionId;
    session.title = self.title;
    /*
    for (NSDictionary *user in [self.data objectForKey:@"userList"]){
        MessageUser *messageUser = [MessageSession createUser];
        messageUser.userId = [user objectForKey:@"userId"];
        messageUser.userName = [user objectForKey:@"userName"];
    }
    */
    [MessageSession saveContext];
}
@end
