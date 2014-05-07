//
//  WHCProjectTaskView.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomUI.h"

#import "WHCTaskDeadlineView.h"
#import "WHCTaskOwnerPickerView.h"
#import "WHCBarInputView.h"

#import "ProjectTasks.h"
#import "AppContact.h"

@interface WHCTaskView : UITableViewController

@property (nonatomic, retain) NSString * taskGroupId;
@property (nonatomic, retain) ProjectTasks * task;

- (BOOL)save;

@end
