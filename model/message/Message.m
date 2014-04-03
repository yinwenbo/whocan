//
//  Message.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-28.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "Message.h"

#define MESSAGE_STATUS_SENDING @"SENDING"
#define MESSAGE_STATUS_SUCCESS @"SUCCESS"
#define MESSAGE_STATUS_FAILED  @"FAILED"

#define MESSAGE_SENDER_SYSTEM @"SYSTEM"
#define MESSAGE_SENDER_ME @"ME"

@implementation Message

@dynamic messageId;
@dynamic content;
@dynamic type;
@dynamic time;
@dynamic senderId;
@dynamic sessionId;
@dynamic status;

- (BOOL)isSystemMessage
{
    return [self.senderId isEqualToString:MESSAGE_SENDER_SYSTEM];
}

- (BOOL)isMySend
{
    return [self.senderId isEqualToString:MESSAGE_SENDER_ME];
}

- (BOOL)isSending
{
    return [self.status isEqualToString:MESSAGE_STATUS_SENDING];
}

- (BOOL)isSendSuccess
{
    return [self.status isEqualToString:MESSAGE_STATUS_SUCCESS];
}

- (BOOL)isSendFailed
{
    return [self.status isEqualToString:MESSAGE_STATUS_FAILED];
}

- (void)setStatusToSending
{
    self.status = MESSAGE_STATUS_SENDING;
}

- (void)setStatusToSuccess
{
    self.status = MESSAGE_STATUS_SUCCESS;
}

- (void)setStatusToFailed
{
    self.status = MESSAGE_STATUS_FAILED;
}

- (void)setSenderIsMe
{
    self.senderId = MESSAGE_SENDER_ME;
}
@end
