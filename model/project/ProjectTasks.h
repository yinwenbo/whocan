//
//  ProjectTasks.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-8.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "WHCModelStore.h"


@interface ProjectTasks : NSManagedObject

@property (nonatomic, retain) NSString * projectId;
@property (nonatomic, retain) NSString * parentId;
@property (nonatomic, retain) NSString * taskId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSDate * deadline;
@property (nonatomic, retain) NSNumber * finished;
@property (nonatomic, retain) NSString * ownerId;
@property (nonatomic, retain) NSString * creatorId;
@property (nonatomic, retain) NSDate * createTime;


+ (void)saveContext;

+ (ProjectTasks *)createTask;
+ (ProjectTasks *)findTask:(NSString *)taskId;

+ (NSArray *)findTasksByProjectId:(NSString *)projectId;
+ (NSArray *)findTasksByParentId:(NSString *)parentId;


@end
