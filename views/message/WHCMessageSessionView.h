//
//  WHCMessageViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHCMessageListView.h"
#import "WHCProjectTaskListView.h"

#import "WHCMessageCell.h"
#import "WHCSystemMessageCell.h"

#import "AppContact.h"

#import "MessageSession.h"
#import "WHCGetMessageSessionAPI.h"
#import "WHCGetMessagesAPI.h"
#import "WHCSendMessageAPI.h"

@interface WHCMessageSessionView : WHCMessageListView <WHCJsonAPIDelegate> {
}


- (void)setMessageSession:(MessageSession*)session;
- (void)setAppContact:(AppContact*)appContact;
@end
