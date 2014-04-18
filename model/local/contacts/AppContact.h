//
//  AppContact.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "WHCModelStore.h"
#import "AddressBookUtil.h"

@interface AppContact : NSManagedObject

@property (nonatomic) int32_t phoneABId;
@property (nonatomic, retain) NSString * phoneABName;
@property (nonatomic, retain) NSString * phoneABNameIndex;
@property (nonatomic, retain) NSString * appId;
@property (nonatomic, retain) NSString * appName;
@property (nonatomic, retain) NSString * appNameIndex;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * mobileNo;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSString * messageSessionId;


+ (AppContact *)createAppContact;
+ (AppContact *)findAppContactByAppId:(NSString *)appId;
+ (AppContact *)findAppContactByABId:(int32_t)recordId;
+ (AppContact *)findAppContactByMobileNo:(NSString *)mobileNo;
+ (AppContact *)findMySelf;

+ (NSArray *)getAppUsers;
+ (NSArray *)getNotAppUser;
+ (NSArray *)getAppContactsInPhone;
+ (NSArray *)getFriends;

+ (NSString *)buildMobileNoParam:(NSArray *)appContacts;
+ (NSString *)buildAppIdParam:(NSArray *)appContacts;

+ (void)saveContext;

+ (void)savePhoneAB:(NSString *)name mobileNo:(NSString *)mobile recordId:(int32_t)recordId;

+ (void)exportPhoneABToAppContacts;

- (NSString *)getName;
- (UIImage *)getIcon;

- (BOOL)isMySelf;
- (BOOL)isMyFriend;
- (BOOL)isMyInvite;
- (BOOL)isInviteMe;
- (BOOL)isAppUser;
- (void)setToMine;

@end
