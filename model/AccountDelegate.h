//
//  AccountDelegate.h
//  whocan
//
//  Created by Yin Wenbo on 14-5-19.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountDelegate : NSObject

+ (HttpJsonAPI *)sendVerifyCodeToMobile:(NSString *)mobileNo;
+ (HttpJsonAPI *)signInByMobileVerifyCode:(NSString *)mobileNo verifyCode:(NSString *)verifyCode;
+ (HttpJsonAPI *)updateAccountInfo:(NSString *)name icon:(NSString *)icon gender:(NSString *)gender;

+ (void)updateBySignInResult:(JsonAPIResult *)apiResult;

@end
