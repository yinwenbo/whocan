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
    NSArray *contacts = [AppContact getNotAppUser];
    NSString *phones = [AppContact buildMobileNoParam:contacts];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   [ClientInfo getToken], @"token",
                                   phones, @"phones", nil];
    return [[WHCUploadContactsAPI alloc] initWithJsonDelegate:@"userRelationAction/uploadLinkMan"
                                                   params:params
                                                 delegate:delegate];

}

@end
