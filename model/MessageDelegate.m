//
//  MessageDelegate.m
//  whocan
//
//  Created by Yin Wenbo on 14-5-14.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "MessageDelegate.h"

@implementation MessageDelegate

+ (void)getNewMessages
{
    NSMutableDictionary *params = [HttpJsonAPI paramsWithToken];
    HttpJsonAPI *api = [HttpJsonAPI getInstance:nil params:params url:api_message_new_messages];
    [api startSynchronize];
}
@end
