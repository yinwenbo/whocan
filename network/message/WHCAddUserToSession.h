//
//  WHCAddUserToSession.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-31.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"

@interface WHCAddUserToSession : WHCJsonAPI

+ (WHCAddUserToSession *)getInstance:(id<WHCJsonAPIDelegate>)delegate
                           sessionId:(NSString*)sessionId
                              userId:(NSString*)userId;
@end
