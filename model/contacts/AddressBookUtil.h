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

#import "AppContact.h"

@interface AddressBookUtil : NSObject

+ (BOOL) hasPermission;

+ (NSInteger) getPhoneABCount;
+ (NSArray *) getPhoneABRecords;
+ (NSString *) getDisplayName: (ABRecordRef)index;
+ (NSString *) getMobilePhoneNo: (ABRecordRef)index;
+ (NSString *) getEmail: (ABRecordRef)index;

@end
