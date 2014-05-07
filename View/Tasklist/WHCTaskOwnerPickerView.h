//
//  WHCTaskOwnerPickerView.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-29.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHCAnalytics.h"
#import "MessageSession.h"
#import "WHCContactCell.h"

@interface WHCTaskOwnerPickerView : UITableViewController

@property (nonatomic, retain) NSString * taskGroupId;
@property (nonatomic, retain) AppContact * selected;

@end
