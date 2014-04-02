//
//  WHCMessageViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHCMessageCell.h"
#import "WHCSystemMessageCell.h"

#import "AppContact.h"
#import "MessageSession.h"

#import "WHCGetMessageSessionAPI.h"
#import "WHCGetMessagesAPI.h"
#import "WHCSendMessageAPI.h"

@interface WHCMessageSessionView : UIViewController <UITableViewDataSource, UITableViewDelegate, WHCJsonAPIDelegate> {
    IBOutlet UITextField *inputText;
    IBOutlet UITableView * _tableView;
    IBOutlet UIView * _inputBarView;

}


- (void)setMessageSession:(MessageSession*)session;
- (void)setAppContact:(AppContact*)appContact;
@end
