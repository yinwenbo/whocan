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
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:appContact.appId forKey:@"friendId"];
    return [[WHCAddUserToSessionAPI alloc] initWithJsonDelegate:@"session/findPrivate"
                                                         params:params
                                                       delegate:delegate];
}

+ (WHCAddUserToSessionAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
                           sessionId:(NSString*)sessionId
                                list:(NSArray*)appContactList
{
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    NSString *userIds = [AppContact buildAppIdParam:appContactList];
    [params setObject:userIds forKey:@"userIds"];
    return [[WHCAddUserToSessionAPI alloc] initWithJsonDelegate:@"session/addUser"
                                                      params:params
                                                    delegate:delegate];
}
- (void)successJsonResult
{
    NSDictionary *result = [self getDictionaryData];
    self.sessionId = [result getString:@"sessionId"];
    self.title = [result getString:@"sessionName"];
    MessageSession *session = [MessageSession createSession];
    session.sessionId = self.sessionId;
    session.title = self.title;
    
    for (NSDictionary *user in [result getArray:@"userList"]){
        MessageUser *messageUser = [MessageSession createUser];
        messageUser.userId = [user getString:@"userId"];
        messageUser.userName = [user getString:@"userName"];
    }
    
    [MessageSession saveContext];
}

@end
