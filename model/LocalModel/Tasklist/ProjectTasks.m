//
//  ProjectTasks.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "ProjectTasks.h"

#define PROJECT_TASK_NAME @"ProjectTasks"

@implementation ProjectTasks

@dynamic projectId;
@dynamic parentId;
@dynamic taskId;
@dynamic title;
@dynamic remark;
@dynamic deadline;
@dynamic finished;
@dynamic ownerId;
@dynamic creatorId;
@dynamic createTime;
@dynamic priority;

+ (void)saveContext
{
    [WHCModelStore saveContext];
}

+ (ProjectTasks *)createTask
{
    return [WHCModelStore insertEntity:PROJECT_TASK_NAME];
}

+ (ProjectTasks *)findTask:(NSString *)taskId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskId = %@", taskId];
    NSArray *results = [WHCModelStore queryEntitys:PROJECT_TASK_NAME predicate:predicate sort:nil];
    if ([results count] >0 ){
        return [results objectAtIndex:0];
    }
    return nil;

}

+ (NSArray *)findTasksByProjectId:(NSString *)projectId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectId = %@ and parentId = NULL", projectId];
    
    NSArray *sort = [[NSArray alloc]initWithObjects:
                     [[NSSortDescriptor alloc] initWithKey:@"createTime" ascending:YES], nil];
    return [WHCModelStore queryEntitys:PROJECT_TASK_NAME predicate:predicate sort:sort];
}

+ (NSArray *)findTasksByParentId:(NSString *)parentId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentId = %@", parentId];
    
    NSArray *sort = [[NSArray alloc]initWithObjects:
                     [[NSSortDescriptor alloc] initWithKey:@"createTime" ascending:YES], nil];
    return [WHCModelStore queryEntitys:PROJECT_TASK_NAME predicate:predicate sort:sort];

}

- (NSString *)getDeadlineLabel
{
    if (self.deadline == nil) {
        return @"已完成";
    }
    NSArray * DayLabels = @[@"今天", @"明天", @"后天"];
    
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:[NSDate date]];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:self.deadline];
    NSInteger day = [[NSCalendar currentCalendar] components:NSDayCalendarUnit
                                                    fromDate:fromDate
                                                      toDate:toDate
                                                     options:0].day;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMMd'日' cccc"];
    NSString * dateLabel = [dateFormatter stringFromDate:self.deadline];
    
    if (day >= 0 && day < [DayLabels count]) {
        return [NSString stringWithFormat:@"%@ %@", [DayLabels objectAtIndex:day], dateLabel];
    }
    
    return dateLabel;
}

@end
