//
//  WHCAppContacts.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-17.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHCModelStore.h"
#import "AppUser.h"
#import "AppContact.h"

@interface WHCAppContactsStore : NSObject

+ (WHCAppContactsStore *)getInstance;

- (NSArray *)getAppUsers;

- (AppContact *)createAppContact;
- (void)saveContext;
- (NSArray *)getAppContacts;
- (AppContact *)findAppContactByABId:(int32_t)recordId;

@end
