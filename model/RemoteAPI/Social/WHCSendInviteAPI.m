//
//  WHCSendInviteAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-25.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSendInviteAPI.h"

@implementation WHCSendInviteAPI

+ (WHCSendInviteAPI*) getInstance:(id<WHCJsonAPIDelegate>)delegate
                         mobileNo:(NSString*)mobileNo
{
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:mobileNo forKey:@"phoneNo"];
    return [[WHCSendInviteAPI alloc] initWithJsonDelegate:@"social/addFriendNoRegister"
                                                   params:params
                                                 delegate:delegate];
}

@end
