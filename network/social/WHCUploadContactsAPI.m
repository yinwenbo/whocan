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
    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:phones forKey:@"phones"];
    return [[WHCUploadContactsAPI alloc] initWithJsonDelegate:@"social/uploadLinkman"
                                                   params:params
                                                 delegate:delegate];

}

@end
