//
//  WHCSignInAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSignInAPI.h"

#define SIGN_IN_PATH @"security/loginAuthCode"

@implementation WHCSignInAPI

+ (WHCSignInAPI*)getInstance:(id<WHCJsonAPIDelegate>)delegate
                    mobileNo:(NSString *)mobileNo
                  verifyCode:(NSString *)verifyCode
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [ClientInfo getDeviceToken], @"deviceToken",
                            mobileNo, @"phoneNo",
                            verifyCode, @"authCode", nil];
    return [[WHCSignInAPI alloc] initWithJsonDelegate:SIGN_IN_PATH
                                               params:params
                                             delegate:delegate];
}

- (void)successJsonResult
{
    [ClientInfo setToken:[self getString:@"userToken"]];

}
@end
