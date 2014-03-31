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
    for (NSDictionary *dict in self.data){
        NSString * mobileNo = [dict valueForKey:@"phoneNo"];
        AppContact *contact = [AppContact findAppContactByMobileNo:mobileNo];
        if (contact == nil){
            contact = [AppContact createAppContact];
            contact.mobileNo = mobileNo;
        }
        contact.appId = [dict valueForKey:@"userId"];
        NSString * name = [dict valueForKey:@"userName"];
        if (![name isKindOfClass:[NSNull class]]){
            contact.appName = [dict valueForKey:@"userName"];
        }
        contact.status = [dict valueForKey:@"status"];
    }
    [AppContact saveContext];
}

@end

