//
//  WHCAddUserToSession.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-31.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"

#import "AppContact.h"
#import "MessageSession.h"

@interface WHCAddUserToSessionAPI : WHCJsonAPI

@property (nonatomic, retain) NSString * sessionId;
@property (nonatomic, retain) NSString * title;

+ (WHCAddUserToSessionAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
                          appContact:(AppContact*)appContact;

+ (WHCAddUserToSessionAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
                           sessionId:(NSString*)sessionId
                                list:(NSArray*)appContactList;
@end
