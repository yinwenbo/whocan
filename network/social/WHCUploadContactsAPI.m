//
//  WHCUploadContactsAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-25.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCUploadContactsAPI.h"

#import "AppContact.h"

@implementation WHCUploadContactsAPI

+ (WHCUploadContactsAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[ClientInfo getToken], @"token", nil];
    NSMutableString *phones = [NSMutableString string];
    NSArray *contacts = [AppContact getNotAppUser];
    if ([contacts count] > 0){
        AppContact * first = [contacts objectAtIndex:0];
        for(AppContact * contact in contacts){
            if(contact == first){
                [phones appendString:contact.mobileNo];
            }else{
                [phones appendFormat:@",%@", contact.mobileNo];
            }
        }
        [params setValue:phones forKey:@"phones"];
    }
    return [[WHCUploadContactsAPI alloc] initWithJsonDelegate:@"userRelationAction/uploadLinkMan"
                                                   params:params
                                                 delegate:delegate];

}

@end
