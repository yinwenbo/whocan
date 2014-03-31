//
//  WHCSendMessageAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-31.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSendMessageAPI.h"

@implementation WHCSendMessageAPI

+ (WHCSendMessageAPI*)getInstance:(id<WHCJsonAPIDelegate>)delegate
                        sessionId:(NSString*)sessionId
                          content:(NSString*)content {
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [ClientInfo getToken], @"token",
                            sessionId, @"roomId",
                            content, @"content", nil];
    return [[WHCSendMessageAPI alloc] initWithJsonDelegate:@"chatService/findPrivateRoom"
                                                          params:params
                                                        delegate:delegate];
}
@end
