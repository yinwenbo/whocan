//
//  WHCAllMessageSessionAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-31.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCAllMessageSessionAPI.h"

@implementation WHCAllMessageSessionAPI

+ (WHCAllMessageSessionAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token", nil];
    return [[WHCAllMessageSessionAPI alloc] initWithJsonDelegate:@"session/findAll"
                                                    params:params
                                                  delegate:delegate];
}
@end
