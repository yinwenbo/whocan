//
//  AppContact.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "AppContact.h"
#import "pinyin.h"

#define APP_CONTACT_NAME @"AppContact"

#define STATUS_FRIEND @"FRIEND"
#define STATUS_NOT_FRIEND @"NOT_FRIEND"
#define STATUS_MY_INVITE @"MY_INVITE"
#define STATUS_INVITE_ME @"INVITE_ME"


@implementation AppContact

@dynamic phoneABId;
@dynamic phoneABName;
@dynamic phoneABNameIndex;
@dynamic appId;
@dynamic appName;
@dynamic appNameIndex;
@dynamic mobileNo;
@dynamic status;
@dynamic messageSessionId;


+ (AppContact *) createAppContact
{
    return [WHCModelStore insertEntity:APP_CONTACT_NAME];
}

+ (NSArray *) getAppContactsInPhone
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"phoneABId != 0"];

    NSArray *sort = [[NSArray alloc]initWithObjects:
                     [[NSSortDescriptor alloc] initWithKey:@"status" ascending:YES],
                     [[NSSortDescriptor alloc] initWithKey:@"phoneABNameIndex" ascending:YES],
                     [[NSSortDescriptor alloc] initWithKey:@"phoneABName" ascending:YES], nil];
    return [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:sort];
}
+ (NSArray *) getNotAppUser
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appId == NULL"];
    return [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:nil];
}
+ (NSArray *) getAppUsers
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appId != NULL"];
    
    NSArray *sort = [[NSArray alloc]initWithObjects:
                     [[NSSortDescriptor alloc] initWithKey:@"phoneABNameIndex" ascending:YES],
                     [[NSSortDescriptor alloc] initWithKey:@"phoneABName" ascending:YES], nil];
    return [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:sort];
}
+ (NSArray *) getFriends
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status == %@", STATUS_FRIEND];
    return [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:nil];
}

+ (AppContact *) findAppContactByABId:(int32_t)recordId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"phoneABId = %i", recordId];
    NSArray *results = [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:nil];
    if ([results count] >0 ){
        return [results objectAtIndex:0];
    }
    return nil;
}
+ (AppContact *) findAppContactByMobileNo:(NSString*)mobileNo
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mobileNo = %@", mobileNo];
    NSArray *results = [WHCModelStore queryEntitys:APP_CONTACT_NAME predicate:predicate sort:nil];
    if ([results count] >0 ){
        return [results objectAtIndex:0];
    }
    return nil;
}

+ (NSString*)buildAppIdParam:(NSArray *)appContacts
{
    if ([appContacts count] == 0){
        return @"";
    }
    NSMutableString *ids = [NSMutableString string];
    AppContact * first = [appContacts objectAtIndex:0];
    for(AppContact * contact in appContacts){
        if(contact == first){
            [ids appendString:contact.appId];
        }else{
            [ids appendFormat:@",%@", contact.appId];
        }
    }
    return [NSString stringWithString:ids];

}

+ (NSString*)buildMobileNoParam:(NSArray *)appContacts
{
    if ([appContacts count] == 0){
        return @"";
    }
    NSMutableString *mobiles = [NSMutableString string];
    AppContact * first = [appContacts objectAtIndex:0];
    for(AppContact * contact in appContacts){
        if(contact == first){
            [mobiles appendString:contact.mobileNo];
        }else{
            [mobiles appendFormat:@",%@", contact.mobileNo];
        }
    }
    return [NSString stringWithString:mobiles];
}

+ (void) savePhoneAB:(NSString*)name mobileNo:(NSString*)mobile recordId:(int32_t)recordId
{
    AppContact * contact = [AppContact findAppContactByMobileNo:mobile];
    if (contact != nil){
        return;
    }
    contact = [WHCModelStore insertEntity:APP_CONTACT_NAME];
    contact.phoneABName = name;
    contact.phoneABId = recordId;
    contact.mobileNo = mobile;
    contact.phoneABNameIndex = [self getNameIndex:name];
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

+ (NSString *) getNameIndex:(NSString*)name
{
    if (name == nil || [name isEqual: @""]){
        return @"!";
    }
    NSString *firstnames = @"曾解仇朴查能乐单";
    NSString *firstindex = @"ZXQPZNYS";
    unichar firstname = [name characterAtIndex:0];
    
    for (int i = 0; i < firstnames.length; i++){
        if ([firstnames characterAtIndex:i] == firstname){
            return [NSString stringWithFormat:@"%c", [firstindex characterAtIndex:i]];
        }
    }
    return [[NSString stringWithFormat:@"%c",pinyinFirstLetter(firstname)] uppercaseString];
}

- (BOOL)isMyFriend
{
    return [STATUS_FRIEND isEqualToString:self.status];
}

- (BOOL)isMyInvite
{
    return [STATUS_MY_INVITE isEqualToString:self.status];
}

- (BOOL)isInviteMe
{
    return [STATUS_INVITE_ME isEqualToString:self.status];
}

- (BOOL)isAppUser
{
    return (self.appId != nil);
}
@end
