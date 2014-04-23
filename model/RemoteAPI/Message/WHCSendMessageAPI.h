//
//  WHCSendMessageAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-31.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"

#import "MessageSession.h"

@interface WHCSendMessageAPI : WHCJsonAPI

@property (nonatomic, retain) Message * message;

+ (WHCSendMessageAPI*)getInstance:(id<WHCJsonAPIDelegate>)delegate
                        sessionId:(NSString*)sessionId
                          content:(NSString*)content;
@end
