//
//  MessageSession.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-28.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "WHCModelStore.h"

#import "Message.h"
#import "MessageUser.h"


@interface MessageSession : NSManagedObject

@property (nonatomic, retain) NSString * sessionId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSDate * lastupdate;
@property (nonatomic, retain) NSNumber * unread;

+ (MessageSession *)createSession;
+ (void)deleteSession:(MessageSession *)session;

+ (MessageUser *)createUser;
+ (Message *)createMessage;

+ (MessageSession *)getSession:(NSString *)sessionId;
+ (NSArray *)getAllSession;

+ (Message *)getLastMessage:(NSString *)sessionId;
+ (Message *)getMessage:(NSString *)sessionId messageId:(NSString *)messageId;
+ (NSArray *)getMessages:(NSString *)sessionId;

+ (MessageUser *)getUser:(NSString *)sessionId userId:(NSString *)userId;
+ (NSArray *)getAllUser:(NSString *)sessionId;

+ (NSArray *)getAppContacts:(NSString *)sessionId;

+ (void)saveContext;

- (UIImage *)getIcon;
@end
