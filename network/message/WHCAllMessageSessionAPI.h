//
//  WHCAllMessageSessionAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-31.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"
#import "MessageSession.h"

@interface WHCAllMessageSessionAPI : WHCJsonAPI

+ (WHCAllMessageSessionAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate;

@end
