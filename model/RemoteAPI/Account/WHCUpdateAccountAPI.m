//
//  WHCUpdateAccountAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-4.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCUpdateAccountAPI.h"

@implementation WHCUpdateAccountAPI

+ (WHCUpdateAccountAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
                          appContact:(AppContact *)appContact
{
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:appContact.appName forKey:@"userName"];
    [params setObject:appContact.icon forKey:@"portrait"];
    [params setObject:appContact.gender forKey:@"gender"];
    return [[WHCUpdateAccountAPI alloc] initWithJsonDelegate:@"user/modify"
                                                       params:params
                                                     delegate:delegate];
}

@end
