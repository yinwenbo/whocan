//
//  WHCPhoneContacts.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-17.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "WHCAppContactsStore.h"
#import "PhoneAB.h"

@interface WHCABUtils : NSObject

+ (BOOL) hasPermission;
+ (void) exportPhoneABToAppContacts;

+ (NSInteger) getCount;
+ (NSString *) getDisplayName: (ABRecordRef)index;
+ (NSString *) getMobilePhoneNo: (ABRecordRef)index;
+ (NSString *) getEmail: (ABRecordRef)index;

@end
