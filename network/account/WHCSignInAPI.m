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
    AppContact *mine = [AppContact findMySelf];
    if (mine == nil){
        mine = [AppContact createAppContact];
        mine.mobileNo = [self getString:@"phoneNo"];
        [mine setToMine];
    }
    mine.gender = [self getString:@"gender"];
    mine.token = [self getString:@"userToken"];
    mine.appId = [self getString:@"userId"];
    mine.appName = [self getString:@"userName"];
    [AppContact saveContext];
}
@end
