//
//  WHCUserFriends.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-19.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHCFriendAPI : NSObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * phoneNo;
@property (nonatomic, retain) NSString * mail;

+ (NSArray*)getFriends;

@end
