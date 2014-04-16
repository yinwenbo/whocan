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
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:toUserId forKey:@"friendId"];
    return [[WHCGetMessageSessionAPI alloc] initWithJsonDelegate:@"session/findPrivate"
                                                   params:params
                                                 delegate:delegate];
}

- (void)successJsonResult
{
    NSDictionary *result = [self getDictionaryData];
    self.sessionId = [result getString:@"sessionId"];
    self.title = [result getString:@"sessionName"];
    
    MessageSession *session = [MessageSession getSession:self.sessionId];
    if (session == nil) {
        session = [MessageSession createSession];
        session.sessionId = self.sessionId;
    }

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
