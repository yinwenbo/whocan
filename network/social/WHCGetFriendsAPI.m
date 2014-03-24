//
//  WHCUserFriends.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-19.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCGetFriendsAPI.h"
@implementation AppFriend

@synthesize userId, userName, mobileNo;

@end

@implementation WHCGetFriendsAPI

+(WHCGetFriendsAPI *)getInstance:(id<WHCHttpAPIDelegate>)delegate
{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:[ClientInfo getToken], @"token", nil];
    return [[WHCGetFriendsAPI alloc] init:@"userRelationAction/findFriendByUserId" params:params delegate:delegate];
}

-(void)onFinished:(WHCHttpAPI *)api
{
    
}

-(NSArray*)getFriends
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (NSDictionary *contact in self.data){
        AppFriend * friend = [[AppFriend alloc]init];
        friend.userId = [contact valueForKey:@"userId"];
        friend.userName = [contact valueForKey:@"userName"];
        friend.mobileNo = [contact valueForKey:@"phoneNo"];
        [result addObject:friend];
    }
    return result;
}

@end

