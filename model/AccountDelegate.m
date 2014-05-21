//
//  AccountDelegate.m
//  whocan
//
//  Created by Yin Wenbo on 14-5-19.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "AccountDelegate.h"
#import "ClientInfo.h"

@implementation AccountDelegate

+ (HttpJsonAPI *)sendVerifyCodeToMobile:(NSString *)mobileNo
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:mobileNo, @"phoneNo", nil];
    return [[HttpJsonAPI alloc] initWithParams:params url:api_security_send_verify_code];
}

+ (HttpJsonAPI *)signInByMobileVerifyCode:(NSString *)mobileNo verifyCode:(NSString *)verifyCode
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[ClientInfo getDeviceToken], @"deviceToken", mobileNo, @"phoneNo", verifyCode, @"authCode", nil];
    return [[HttpJsonAPI alloc] initWithParams:params url:api_security_sign_in];
}

+ (HttpJsonAPI *)updateAccountInfo:(NSString *)name icon:(NSString *)icon gender:(NSString *)gender
{
    NSMutableDictionary *params = [HttpJsonAPI paramsWithToken];
    [params setObject:name forKey:@"userName"];
    [params setObject:icon forKey:@"portrait"];
    [params setObject:gender forKey:@"gender"];
    return [[HttpJsonAPI alloc] initWithParams:params url:api_account_modify];
}

+ (void)updateBySignInResult:(JsonAPIResult *)apiResult
{
    NSDictionary *result = apiResult.data;
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
