//
//  WHCSyncTask.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-21.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WHCRemoteAPI.h"

@interface WHCSyncTask : NSObject <WHCJsonAPIDelegate>

+ (void)start;
+ (void)stop;

@end
