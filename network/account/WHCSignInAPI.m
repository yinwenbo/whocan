//
//  WHCSignInAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSignInAPI.h"

#define SIGN_IN_PATH @"loginByAuthCode"

@implementation WHCSignInAPI

+ (WHCSignInAPI*)getInstance:(id<WHCJsonAPIDelegate>)delegate
                    mobileNo:(NSString *)mobileNo
                  verifyCode:(NSString *)verifyCode
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mobileNo, @"phoneNo",
                            verifyCode, @"authCode", nil];
    return [[WHCSignInAPI alloc] initWithJsonDelegate:SIGN_IN_PATH
                                               params:params
                                             delegate:delegate];
}

- (NSString*)getToken
{
    return [self getString:@"userToken"];
}
@end
