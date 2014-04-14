//
//  WHCUserFriends.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-19.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCGetFriendsAPI.h"

@interface WHCGetFriendsAPI(){

}
@end

@implementation WHCGetFriendsAPI

+(WHCGetFriendsAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:[ClientInfo getToken], @"token", nil];
    return [[WHCGetFriendsAPI alloc] initWithJsonDelegate:@"social/findAll"
                                                   params:params
                                                 delegate:delegate];
}

-(void)successJsonResult
{
    NSLog(@"%@", self.data);
    AppContact *mine = [AppContact findMySelf];
    for (NSDictionary *dict in self.data){
        NSString * mobileNo = [self getString:dict key:@"phoneNo"];
        AppContact *contact = [AppContact findAppContactByMobileNo:mobileNo];
        if (contact == mine) {
            break;
        }
        if (contact == nil){
            contact = [AppContact createAppContact];
            contact.mobileNo = mobileNo;
        }
        contact.icon = [self getString:dict key:@"portrait"];
        contact.gender = [self getString:dict key:@"gender"];
        contact.appId = [self getString:dict key:@"userId"];
        contact.appName = [self getString:dict key:@"userName"];
    }
    [AppContact saveContext];
}

@end

