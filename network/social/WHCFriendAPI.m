//
//  WHCUserFriends.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-19.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCFriendAPI.h"

@implementation WHCFriendAPI

@synthesize userId, userName, phoneNo, mail;

+(NSArray*)getFriends
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    [result addObject:[WHCFriendAPI createFriend:@"1" name:@"老蒋" phone:@"15810101046" mail:@""]];
//    [result addObject:[WHCFriendAPI createFriend:@"2" name:@"晓峰" phone:@"18500190692" mail:@""]];
    [result addObject:[WHCFriendAPI createFriend:@"3" name:@"fish" phone:@"15321508861" mail:@""]];
    return result;
}

+(WHCFriendAPI*)createFriend:(NSString*)uid name:(NSString*)name phone:(NSString*)phone mail:(NSString*)mail
{
    WHCFriendAPI *friend = [[WHCFriendAPI alloc]init];
    friend.userId = uid;
    friend.userName = name;
    friend.phoneNo = phone;
    friend.mail = mail;
    return friend;
}
@end
