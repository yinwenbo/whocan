//
//  WHCSendVerifyCodeAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSendVerifyCodeAPI.h"

#define SEND_VERIFY_CODE_PATH @"sendAuthCode"

@implementation WHCSendVerifyCodeAPI

+ (WHCSendVerifyCodeAPI *)getInstance:(id<WHCHttpAPIDelegate>)delegate
                             mobileNo:(NSString *)mobileNo
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:mobileNo, @"phoneNo", nil];
    return [[WHCSendVerifyCodeAPI alloc] init:SEND_VERIFY_CODE_PATH params:params delegate:delegate];
}

@end
