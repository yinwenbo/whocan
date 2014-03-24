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
#import "ClientInfo.h"

@interface AppFriend : NSObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * mobileNo;

@end

@interface WHCGetFriendsAPI : WHCJsonAPI

+ (WHCGetFriendsAPI*) getInstance:(id<WHCHttpAPIDelegate>)delegate;

- (NSArray *) getFriends;
@end

