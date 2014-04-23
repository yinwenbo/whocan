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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectId = %@ and parentId = %@", projectId, projectId];
    
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

@end
