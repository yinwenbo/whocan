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
@dynamic appMobileNo;
@dynamic appMail;

@dynamic isAppFriend;
@dynamic isAppUser;
@dynamic contactId;

+ (AppContact *) createAppContact
{
    AppContact * contact = [WHCModelStore insertEntity:APP_CONTACT_NAME];
    contact.contactId = [[[NSUUID alloc] init] UUIDString];
    return contact;
}

+ (NSArray *)getAppContacts
{
    return [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:nil sort:nil];
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
+ (void)saveAppUser:(NSString*)appId appName:(NSString*)appName appMobileNo:(NSString*)mobile appMail:(NSString *)mail
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appMobileNo = %i", mobile];
    NSArray *results = [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:nil];
    
}

+ (void) exportPhoneABToAppContacts
{
    NSArray * records = [AddressBookUtil getPhoneABRecords];
    for (int i = 0; i < records.count; i ++){
        ABRecordRef record = (ABRecordRef)CFBridgingRetain([records objectAtIndex:i]);
        ABRecordID recordId = ABRecordGetRecordID(record);
        AppContact * contact = [AppContact findAppContactByABId:recordId];
        if (contact == nil){
            contact = [AppContact createAppContact];
            contact.phoneABName = [AddressBookUtil getDisplayName:record];
            contact.phoneABId = recordId;
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
