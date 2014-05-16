//
//  SocialDelegate.m
//  whocan
//
//  Created by Yin Wenbo on 14-5-15.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "SocialDelegate.h"

@implementation SocialDelegate

static HttpJsonAPI * __contactUploadApi;

+ (void)uploadContactsInBackground
{
    if (__contactUploadApi) {
        [__contactUploadApi cancelRequest];
        __contactUploadApi = nil;
    }
    __contactUploadApi = [self uploadContacts];
    [__contactUploadApi startAsynchronize:^(HttpJsonAPI *api) {
        __contactUploadApi = nil;
    } showProgressOn:nil];
}

+ (HttpJsonAPI *)uploadContacts
{
    NSArray *contacts = [AppContact getNotAppUser];
    NSString *phones = [AppContact buildMobileNoParam:contacts];
    NSMutableDictionary *params = [HttpJsonAPI paramsWithToken];
    [params setObject:phones forKey:@"phones"];
    return [[HttpJsonAPI alloc] initWithParams:params url:api_social_upload_contacts];
}

+ (HttpJsonAPI *)addFriend:(NSString *)appUserId
{
    NSMutableDictionary *params = [HttpJsonAPI paramsWithToken];
    [params setObject:appUserId forKey:@"friendId"];
    return [[HttpJsonAPI alloc] initWithParams:params url:api_social_add_friend];
}

+ (HttpJsonAPI *)getFriends
{
    return [[HttpJsonAPI alloc] initWithParams:[HttpJsonAPI paramsWithToken]
                                           url:api_social_get_friends];
}

+ (HttpJsonAPI *)sendInvite:(NSString *)mobileNo
{
    NSMutableDictionary *params = [HttpJsonAPI paramsWithToken];
    [params setObject:mobileNo forKey:@"phoneNo"];
    return [[HttpJsonAPI alloc] initWithParams:params url:api_social_send_invite];
}

+ (void)saveFriendsByAPIResult:(JsonAPIResult *)apiResult
{
    NSArray * result = apiResult.data;
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
