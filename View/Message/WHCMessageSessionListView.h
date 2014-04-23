//
//  WHCMessageGroupViewController.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "WHCMessageView.h"
#import "WHCContactPickerView.h"
#import "WHCMessageSessionCell.h"

#import "MessageSession.h"
#import "ClientInfo.h"

#import "WHCMakeMessageReadAPI.h"
#import "WHCNewMessageAPI.h"
#import "WHCAddUserToSessionAPI.h"
#import "WHCUploadContactsAPI.h"

@interface WHCMessageSessionListView : UITableViewController<WHCJsonAPIDelegate>

@end
