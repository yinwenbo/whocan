//
//  WHCPhoneContacts.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-17.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "AddressBookUtil.h"

@implementation AddressBookUtil

static bool abAccessPerission;

+ (ABAddressBookRef)getAddressBookRef
{
    CFErrorRef error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(nil, &error);
    if(error){
        NSLog(@"get phone address book error: %@", error);
    }
    return addressBook;
}

+ (void)releaseRef:(ABAddressBookRef)addressBook
{
    if(addressBook != nil){
        CFRelease(addressBook);
    }
}

+ (BOOL)hasPermission
{
    ABAddressBookRef addressBook = [AddressBookUtil getAddressBookRef];
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        abAccessPerission = granted;
        if(error){
            NSLog(@"get address book granted error %@", error);
        }
    });

//    [AddressBookUtil releaseRef:addressBook];
    return abAccessPerission;
}

+ (NSInteger) getPhoneABCount
{
    ABAddressBookRef addressBook = [AddressBookUtil getAddressBookRef];
    CFIndex result = ABAddressBookGetPersonCount(addressBook);
//    [AddressBookUtil releaseRef:addressBook];
    return result;
}

+ (NSArray*) getPhoneABRecords
{
    ABAddressBookRef addressBook = [AddressBookUtil getAddressBookRef];
    NSArray * result = (NSArray *)CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    return result;
}

+ (NSString *) getDisplayName: (ABRecordRef)record
{
    NSString *firstname = (NSString *) CFBridgingRelease(ABRecordCopyValue(record, kABPersonFirstNameProperty));
    if(firstname == nil){
        firstname = @"";
    }
    NSString *lastname = (NSString *) CFBridgingRelease(ABRecordCopyValue(record, kABPersonLastNameProperty));
    if(lastname == nil){
        lastname = @"";
    }
    NSString *middlename = (NSString *) CFBridgingRelease(ABRecordCopyValue(record, kABPersonMiddleNameProperty));
    if(middlename == nil){
        middlename = @"";
    }

    if (kABPersonCompositeNameFormatFirstNameFirst == ABPersonGetCompositeNameFormatForRecord(record)){
        return [NSString stringWithFormat:@"%@%@%@", firstname, middlename, lastname];
    }else{
        return [NSString stringWithFormat:@"%@%@%@", lastname, middlename, firstname];
    }
}

+ (NSArray *)getAllMobileNo: (ABRecordRef)record
{
    ABMultiValueRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for(long i = 0; i < ABMultiValueGetCount(phones); i++){
        CFStringRef value = ABMultiValueCopyValueAtIndex(phones, i);
        CFStringRef label = ABMultiValueCopyLabelAtIndex(phones, i);
        NSString *localLabel = (NSString *)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(label));
        NSLog(@"phone %@ %@", value, localLabel);
        [result addObject:[AddressBookUtil formatMobileNo:(NSString *)CFBridgingRelease(value)]];
        if(label) CFRelease(label);
    }
    CFRelease(phones);
    return result;
}

+ (NSString *) getMobilePhoneNo: (ABRecordRef)record
{
    NSString *phone = nil;
    CFTypeRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
    CFIndex count = ABMultiValueGetCount(phones);
    for(CFIndex i = 0; i < count; i++){
        CFStringRef value = ABMultiValueCopyValueAtIndex(phones, i);
        CFStringRef label = ABMultiValueCopyLabelAtIndex(phones, i);
        
        NSString *localLabel = (NSString *)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(label));
        NSLog(@"%@ (%@, %@)", value, label, localLabel);
        if([localLabel isEqualToString:@"mobile"]){
            phone = (NSString *)CFBridgingRelease(value);
            CFRelease(label);
            break;
        }
        
        if([localLabel isEqualToString:@"work"]){
            phone = (NSString *)CFBridgingRelease(value);
            CFRelease(label);
            break;
        }
        
    }
    if(phone == nil){
        phone = @"";
    } else {
        phone = [AddressBookUtil formatMobileNo:phone];
    }
    CFRelease(phones);
    return phone;

}

+ (NSString *) formatMobileNo: (NSString*)mobleNo
{
    NSMutableString * result = [NSMutableString stringWithString:mobleNo];
    return [result stringByReplacingOccurrencesOfString:@"[-()\\s]"
                                             withString:@""
                                                options:NSRegularExpressionSearch
                                                  range:(NSRange){0, mobleNo.length}];
//    return [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+ (NSString *) getEmail: (ABRecordRef)record
{
    NSString *mail = nil;
    ABMultiValueRef mails = ABRecordCopyValue(record, kABPersonEmailProperty);
    for(long index = 0; index < ABMultiValueGetCount(mails); index++){
        CFStringRef value = ABMultiValueCopyValueAtIndex(mails, index);
        CFStringRef label = ABMultiValueCopyLabelAtIndex(mails, index);
        
        NSString *localLabel = (NSString *)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(label));
        NSLog(@"%@ (%@, %@)", value, label, localLabel);
        if(value != nil){
            CFRelease(value);
        }
        if(label != nil){
            CFRelease(label);
        }
        mail = (NSString *)CFBridgingRelease(value);
        break;
        
    }
    if(mail == nil){
        mail = @"";
    }
    CFRelease(mails);
    return mail;

}


@end
