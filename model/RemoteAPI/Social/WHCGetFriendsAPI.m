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
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    return [[WHCGetFriendsAPI alloc] initWithJsonDelegate:@"social/findAll"
                                                   params:params
                                                 delegate:delegate];
}

-(void)successJsonResult
{
    NSArray * result = [self getArrayData];
    AppContact *mine = [AppContact findMySelf];
    
    for (NSDictionary *dict in result){
        NSString * mobileNo = [dict getString:@"phoneNo"];
        AppContact *contact = [AppContact findAppContactByMobileNo:mobileNo];
        if ([mobileNo isEqualToString:mine.mobileNo]) {
            continue;
        }
        if (contact == nil){
            contact = [AppContact createAppContact];
            contact.mobileNo = mobileNo;
        }
        contact.icon = [dict getString:@"portrait"];
        contact.gender = [dict getString:@"gender"];
        contact.appId = [dict getString:@"userId"];
        contact.appName = [dict getString:@"userName"];
        contact.status = [dict getString:@"status"];
    }
    [AppContact saveContext];
}

@end

