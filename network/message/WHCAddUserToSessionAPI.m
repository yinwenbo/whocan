//
//  WHCAddUserToSession.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-31.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCAddUserToSessionAPI.h"

@implementation WHCAddUserToSessionAPI

@synthesize sessionId, title;

+ (WHCAddUserToSessionAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
                          appContact:(AppContact*)appContact
{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token",
                            appContact.appId, @"friendId", nil];
    return [[WHCAddUserToSessionAPI alloc] initWithJsonDelegate:@"session/findPrivate"
                                                         params:params
                                                       delegate:delegate];
}

+ (WHCAddUserToSessionAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
                           sessionId:(NSString*)sessionId
                                list:(NSArray*)appContactList
{
    NSString *userIds = [AppContact buildAppIdParam:appContactList];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token",
                            userIds, @"userIds", nil];
    return [[WHCAddUserToSessionAPI alloc] initWithJsonDelegate:@"session/addUser"
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
    
    for (NSDictionary *user in [self.data objectForKey:@"userList"]){
        MessageUser *messageUser = [MessageSession createUser];
        messageUser.userId = [user objectForKey:@"userId"];
        messageUser.userName = [user objectForKey:@"userName"];
    }
    
    [MessageSession saveContext];
}

@end
