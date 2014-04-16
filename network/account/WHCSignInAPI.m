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
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:[ClientInfo getDeviceToken] forKey:@"deviceToken"];
    [params setObject:mobileNo forKey:@"phoneNo"];
    [params setObject:verifyCode forKey:@"authCode"];
    return [[WHCSignInAPI alloc] initWithJsonDelegate:SIGN_IN_PATH
                                               params:params
                                             delegate:delegate];
}

- (void)successJsonResult
{
    NSDictionary *result = [self getDictionaryData];
    AppContact *mine = [AppContact findMySelf];
    if (mine == nil){
        mine = [AppContact createAppContact];
        mine.mobileNo = [result getString:@"phoneNo"];
    }
    [mine setToMine];    
    mine.gender = [result getString:@"gender"];
    mine.token = [result getString:@"userToken"];
    mine.appId = [result getString:@"userId"];
    mine.appName = [result getString:@"userName"];
    [AppContact saveContext];
}
@end
