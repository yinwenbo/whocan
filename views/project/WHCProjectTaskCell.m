//
//  WHCProjectTaskCell.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCProjectTaskCell.h"

@implementation WHCProjectTaskCell

@synthesize task = _task;

@synthesize icon;
@synthesize title;
@synthesize detail;
@synthesize checked;

-(void)setTask:(ProjectTasks *)task
{
    _task = task;
    AppContact * owner = [AppContact findAppContactByAppId:task.ownerId];

    [icon setImage:[UIImage imageNamed:owner.icon]];
    [title setText:task.title];
    [detail setText: [NSString stringWithFormat:@"%@", task.createTime]];
    [checked setSelected: [task.finished boolValue]];
    [checked addTarget:self action:@selector(onTaskFinishedChange) forControlEvents:UIControlEventTouchUpInside];
}

-(void)onTaskFinishedChange
{
    BOOL finished = !checked.selected;
    _task.finished = [NSNumber numberWithBool:finished];
    [ProjectTasks saveContext];
    [checked setSelected:finished];
}

@end
