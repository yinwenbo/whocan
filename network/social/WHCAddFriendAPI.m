//
//  WHCAddFriendAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-25.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCAddFriendAPI.h"

@implementation WHCAddFriendAPI


+ (WHCAddFriendAPI*) getInstance:(id<WHCJsonAPIDelegate>)delegate
                          userId:(NSString*)appUserId
{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token",
                            appUserId, @"userId", nil];
    return [[WHCAddFriendAPI alloc] initWithJsonDelegate:@"userRelationAction/findAllRelationByUserId"
                                                   params:params
                                                 delegate:delegate];
    
}


@end
