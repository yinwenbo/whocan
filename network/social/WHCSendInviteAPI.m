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
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token",
                            mobileNo, @"phoneNo", nil];
    return [[WHCSendInviteAPI alloc] initWithJsonDelegate:@"userRelationAction/findAllRelationByUserId"
                                                   params:params
                                                 delegate:delegate];
   
}

@end
