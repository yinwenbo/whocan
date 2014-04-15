//
//  WHCMessageViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHCInputListView.h"
#import "WHCProjectTaskListView.h"

#import "WHCMessageCell.h"

#import "AppContact.h"

#import "MessageSession.h"
#import "WHCNewMessageAPI.h"
#import "WHCGetMessageSessionAPI.h"
#import "WHCGetMessagesAPI.h"
#import "WHCSendMessageAPI.h"

@interface WHCMessageView : WHCInputListView <WHCJsonAPIDelegate> {
}


- (void)setMessageSession:(MessageSession*)session;
- (void)setAppContact:(AppContact*)appContact;
@end
