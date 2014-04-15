//
//  WHCProjectTaskListView.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCInputListView.h"

#import "WHCProjectTaskView.h"
#import "WHCProjectTaskCell.h"

#import "ProjectTasks.h"
#import "AppContact.h"


@interface WHCProjectTaskListView : WHCInputListView <UIActionSheetDelegate>

- (void)setProjectId:(NSString *)projectId;

@end
