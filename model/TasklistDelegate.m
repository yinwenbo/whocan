//
//  TasklistDelegate.m
//  whocan
//
//  Created by Yin Wenbo on 14-5-15.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "TasklistDelegate.h"

@implementation TasklistDelegate

+ (HttpJsonAPI *)findTasklistByGroupId:(NSString *)groupId
{
    NSMutableDictionary *params = [HttpJsonAPI paramsWithToken];
    [params setObject:groupId forKey:@"groupId"];
    return [[HttpJsonAPI alloc]initWithParams:params url:api_tasklist_find_by_group_id];
}

+ (HttpJsonAPI *)createTask:(NSString *)groupId
                      title:(NSString *)title
                description:(NSString *)description
                       rate:(NSInteger)rate
                        top:(NSInteger)top
                      owner:(NSString *)owner
                   deadline:(NSDate *)deadline
                     status:(NSString *)status
                   parentId:(NSString *)parentId
                       type:(NSString *)type
{
    NSMutableDictionary *params = [HttpJsonAPI paramsWithToken];
    [params setObject:groupId forKey:@"groupId"];
    [params setObject:title forKey:@"title"];
    [params setObject:description forKey:@"description"];
    [params setObject:owner forKey:@"owner"];
    [params setObject:deadline forKey:@"deadline"];
    [params setObject:status forKey:@"status"];
    [params setObject:parentId forKey:@"parentId"];
    [params setObject:type forKey:@"type"];
    [params setObject:[NSNumber numberWithInteger:rate] forKey:@"rate"];
    [params setObject:[NSNumber numberWithInteger:top] forKey:@"top"];
    return [[HttpJsonAPI alloc] initWithParams:params url:api_tasklist_create];
}

+ (void)saveTaskByAPIResult:(JsonAPIResult *)apiResult
{
//    ProjectTasks *task = [WHCModelStore insertEntity:[[ProjectTasks class] description]];
    
}

+ (void)updateTasklistByAPIResult:(JsonAPIResult *)apiResult
{
    NSArray * tasklist = apiResult.data;
    for (NSDictionary *td in tasklist) {
        ProjectTasks * task = [ProjectTasks findTask:[td getString:@"taskId"]];
        if (!task) {
            task = [WHCModelStore insertEntity:[[ProjectTasks class] description]];
        }
        [task setProjectId:[td getString:@"groupId"]];
        [task setTaskId:[td getString:@"taskId"]];
        [task setTitle:[td getString:@"title"]];
        [task setRemark:[td getString:@"description"]];
        [task setOwnerId:[td getString:@"owner"]];
        [task setDeadline:[td getDate:@"deadline"]];
        [task setPriority:[td getNumber:@"rate"]];
    }
    
}
@end
