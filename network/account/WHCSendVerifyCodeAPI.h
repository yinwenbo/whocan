//
//  WHCSendVerifyCodeAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WHCJsonAPI.h"

@interface WHCSendVerifyCodeAPI : WHCJsonAPI

+ (WHCSendVerifyCodeAPI*) getInstance:(id<WHCJsonAPIDelegate>)delegate
                             mobileNo:(NSString*)mobileNo;

@end
