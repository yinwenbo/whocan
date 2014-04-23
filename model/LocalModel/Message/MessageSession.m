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

+ (void)deleteSession:(MessageSession *)session
{
    for (Message *message in [MessageSession getMessages:session.sessionId]){
        [WHCModelStore deleteEntity:message];
    }
    for (MessageUser *user in [MessageSession getAllUser:session.sessionId]){
        [WHCModelStore deleteEntity:user];
    }
    [WHCModelStore deleteEntity:session];
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

+ (Message *)getLastMessage:(NSString *)sessionId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sessionId == %@", sessionId];
    NSArray *sort = [[NSArray alloc]initWithObjects:
                     [[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO], nil];
    NSArray * list = [WHCModelStore queryEntitys:MESSAGE_NAME predicate:predicate sort:sort];
    if ([list count] > 0) {
        return [list objectAtIndex:0];
    }
    return nil;
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
    
//    NSArray *sort = [[NSArray alloc]initWithObjects:
//                     [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES], nil];
    return [WHCModelStore queryEntitys:MESSAGE_NAME predicate:predicate sort:nil];
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

- (UIImage *)getIcon
{
    AppContact * user = [AppContact findAppContactByAppId:self.sessionId];
    if (user) {
        return [user getIcon];
    }
    return [self getSessionIcon];
}

- (UIImage *)getSessionIcon
{
    return nil;
    NSMutableArray * users = [NSMutableArray arrayWithArray:[MessageSession getAllUser:self.sessionId]];
    AppContact * mine = [AppContact findMySelf];
    for (MessageUser *user in users) {
        if ([user.userId isEqualToString:mine.appId]) {
            [users removeObject:user];
        }
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    
    for (int i = 0 ; i < [users count]; i++) {
        MessageUser * messageUser = [users objectAtIndex:i];
        UIImage * icon = [[AppContact findAppContactByAppId: messageUser.userId] getIcon];
        [icon drawInRect: CGRectMake(1 + (i % 3 * 16), 1 + (i % 3 * 16), 64, 64)];
    }
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

@end
