//
//  Message.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-28.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "Message.h"


@implementation Message

@dynamic messageId;
@dynamic content;
@dynamic type;
@dynamic time;
@dynamic senderId;
@dynamic sessionId;
@dynamic status;

-(BOOL)isSystemMessage
{
    return [self.senderId isEqualToString:@"SYSTEM"];
}
@end
