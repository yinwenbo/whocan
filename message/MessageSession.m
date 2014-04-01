//
//  MessageSession.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-28.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "MessageSession.h"

#define MESSAGE_SESSION_NAME @"MessageSession"
#define MESSAGE_USER_NAME @"MessageUser"
#define MESSAGE_NAME @"Message"

@implementation MessageSession

@dynamic sessionId;
@dynamic title;
@dynamic detail;
@dynamic lastupdate;
@dynamic unread;

+ (MessageSession *)createSession
{
    return [WHCModelStore insertEntity:MESSAGE_SESSION_NAME];
}

+ (MessageUser *)createUser
{
    return [WHCModelStore insertEntity:MESSAGE_USER_NAME];
}

+ (Message *)createMessage
{
    return [WHCModelStore insertEntity:MESSAGE_NAME];
}

+ (MessageSession *)getSession:(NSString *)sessionId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sessionId == %@", sessionId];
    NSArray * list = [WHCModelStore queryEntitys:MESSAGE_SESSION_NAME predicate:predicate sort:nil];
    if ([list count] > 0) {
        return [list objectAtIndex:0];
    }
    return nil;
}

+ (NSArray *)getAllSession
{
    NSArray *sort = [[NSArray alloc]initWithObjects:
                     [[NSSortDescriptor alloc] initWithKey:@"lastupdate" ascending:NO], nil];
    return [WHCModelStore queryEntitys:MESSAGE_SESSION_NAME predicate:nil sort:sort];
}

+ (Message *)getMessage:(NSString *)sessionId messageId:(NSString *)messageId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sessionId == %@ and messageId == %@", sessionId, messageId];
    NSArray * list = [WHCModelStore queryEntitys:MESSAGE_NAME predicate:predicate sort:nil];
    if ([list count] > 0) {
        return [list objectAtIndex:0];
    }
    return nil;
}

+ (NSArray *)getMessages:(NSString *)sessionId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sessionId == %@", sessionId];
    
    NSArray *sort = [[NSArray alloc]initWithObjects:
                     [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES], nil];
    return [WHCModelStore queryEntitys:MESSAGE_NAME predicate:predicate sort:sort];
}

+ (MessageUser *)getUser:(NSString *)sessionId userId:(NSString *)userId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sessionId == %@ and userId == %@", sessionId, userId];
    NSArray * list = [WHCModelStore queryEntitys:MESSAGE_USER_NAME predicate:predicate sort:nil];
    if ([list count] > 0) {
        return [list objectAtIndex:0];
    }
    return nil;
}

+ (NSArray *)getAllUser:(NSString *)sessionId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sessionId == %@", sessionId];
    return [WHCModelStore queryEntitys:MESSAGE_USER_NAME predicate:predicate sort:nil];
}

+ (void)saveContext
{
    [WHCModelStore saveContext];
}

@end
