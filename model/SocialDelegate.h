//
//  SocialDelegate.h
//  whocan
//
//  Created by Yin Wenbo on 14-5-15.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocialDelegate : NSObject

+ (HttpJsonAPI *)uploadContacts;
+ (HttpJsonAPI *)sendInvite:(NSString *)mobileNo;
+ (HttpJsonAPI *)getFriends;
+ (HttpJsonAPI *)addFriend:(NSString *)appUserId;

+ (void)uploadContactsInBackground;

+ (void)saveFriendsByAPIResult:(JsonAPIResult *)apiResult;
@end
