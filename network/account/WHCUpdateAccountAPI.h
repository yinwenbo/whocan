//
//  WHCUpdateAccountAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-4.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"

#import "AppContact.h"
#import "ClientInfo.h"

@interface WHCUpdateAccountAPI : WHCJsonAPI

+ (WHCUpdateAccountAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate appContact:(AppContact *)appContact;

@end
