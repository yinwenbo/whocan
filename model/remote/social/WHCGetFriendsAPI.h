//
//  WHCUserFriends.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-19.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WHCJsonAPI.h"
#import "AppContact.h"

@interface WHCGetFriendsAPI : WHCJsonAPI

+ (WHCGetFriendsAPI*) getInstance:(id<WHCJsonAPIDelegate>)delegate;

@end

