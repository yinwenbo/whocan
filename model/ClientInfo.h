//
//  ClentInfo.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-21.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClientInfo : NSObject


+ (NSString *)getToken;
+ (void)setToken:(NSString *)token;

@end
