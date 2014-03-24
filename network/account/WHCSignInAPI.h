//
//  WHCSignInAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WHCJsonAPI.h"

@interface WHCSignInAPI : WHCJsonAPI


+ (WHCSignInAPI*) getInstance:(id<WHCHttpAPIDelegate>)delegate
                     mobileNo:(NSString*)mobileNo
                   verifyCode:(NSString*)verifyCode;

- (NSString *)getToken;

@end
