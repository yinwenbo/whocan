//
//  WHCProjectTaskListView.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMessageListView.h"

#import "WHCProjectTaskView.h"
#import "WHCProjectTaskCell.h"
#import "WHCViewUtils.h"

#import "ProjectTasks.h"
#import "AppContact.h"


@interface WHCProjectTaskListView : WHCMessageListView <UIActionSheetDelegate>

- (void)setProjectId:(NSString *)projectId;

@end
