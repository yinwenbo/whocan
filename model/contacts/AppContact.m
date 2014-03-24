//
//  AppContact.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "AppContact.h"

#define APP_CONTACT_NAME @"AppContact"

@implementation AppContact

@dynamic phoneABId;
@dynamic phoneABName;
@dynamic appId;
@dynamic appName;
@dynamic mobileNo;

@dynamic isAppFriend;
@dynamic isAppUser;

+ (AppContact *) createAppContact
{
    return [WHCModelStore insertEntity:APP_CONTACT_NAME];
}

+ (NSArray *)getAppContactsInPhone
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"phoneABId != 0"];

    NSSortDescriptor *friend = [[NSSortDescriptor alloc] initWithKey:@"isAppFriend" ascending:NO];
    NSSortDescriptor *appUser = [[NSSortDescriptor alloc] initWithKey:@"isAppUser" ascending:YES];
    NSArray *sort = [[NSArray alloc]initWithObjects:appUser, friend, nil];
    return [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:sort];
}

+ (NSArray *)getFriends
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAppFriend == %@", [NSNumber numberWithBool:YES]];
    return [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:nil];
}

+ (AppContact *)findAppContactByABId:(int32_t)recordId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"phoneABId = %i", recordId];
    NSArray *results = [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:nil];
    if ([results count] >0 ){
        return [results objectAtIndex:0];
    }
    return nil;
}
+ (AppContact *)findAppContactByMobileNo:(NSString*)mobileNo
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mobileNo = %@", mobileNo];
    NSArray *results = [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:nil];
    if ([results count] >0 ){
        return [results objectAtIndex:0];
    }
    return nil;
}
+ (void)saveAppUser:(NSString*)appId name:(NSString*)appName mobileNo:(NSString*)mobile
{
    AppContact * contact = [AppContact findAppContactByMobileNo:mobile];
    if (contact == nil){
        contact = [WHCModelStore insertEntity:APP_CONTACT_NAME];
    }
    contact.appId = appId;
    contact.isAppFriend = true;
    contact.isAppUser = true;
    contact.appName = appName;
    contact.mobileNo = mobile;

}
+ (void)savePhoneAB:(NSString*)name mobileNo:(NSString*)mobile recordId:(int32_t)recordId
{
    AppContact * contact = [AppContact findAppContactByMobileNo:mobile];
    if (contact != nil){
        return;
    }
    contact = [WHCModelStore insertEntity:APP_CONTACT_NAME];
    contact.phoneABName = name;
    contact.phoneABId = recordId;
    contact.mobileNo = mobile;
}

+ (void) exportPhoneABToAppContacts
{
    NSArray * records = [AddressBookUtil getPhoneABRecords];
    for (int i = 0; i < records.count; i ++){
        ABRecordRef record = (ABRecordRef)CFBridgingRetain([records objectAtIndex:i]);
        ABRecordID recordId = ABRecordGetRecordID(record);
        NSArray *mobileNos = [AddressBookUtil getAllMobileNo:record];
        NSString *name = [AddressBookUtil getDisplayName:record];
        for(NSString *mobile in mobileNos){
            [self savePhoneAB:name mobileNo:mobile recordId:recordId];
        }
        CFRelease(record);
    }
    [AppContact saveContext];
}


+ (void) saveContext
{
    [WHCModelStore saveContext];
}

@end
