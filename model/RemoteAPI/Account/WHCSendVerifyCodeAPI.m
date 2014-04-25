//
//  WHCSendVerifyCodeAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSendVerifyCodeAPI.h"

#define SEND_VERIFY_CODE_PATH @"security/sendAuthCode"

@implementation WHCSendVerifyCodeAPI

+ (WHCSendVerifyCodeAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
                             mobileNo:(NSString *)mobileNo
{
    
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:mobileNo forKey:@"phoneNo"];
    return [[WHCSendVerifyCodeAPI alloc] initWithJsonDelegate:SEND_VERIFY_CODE_PATH
                                                       params:params
                                                     delegate:delegate];
}

@end