//
//  TasklistDelegate.h
//  whocan
//
//  Created by Yin Wenbo on 14-5-15.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectTasks.h"

@interface TasklistDelegate : NSObject

+ (HttpJsonAPI *)findTasklistByGroupId:(NSString *)groupId;
+ (HttpJsonAPI *)createTask:(NSString *)groupId
                      title:(NSString *)title
                description:(NSString *)description
                       rate:(NSInteger)rete
                        top:(NSInteger)top
                      owner:(NSString *)owner
                   deadline:(NSDate *)deadline
                     status:(NSString *)status
                   parentId:(NSString *)parentId
                       type:(NSString *)type;

+ (void)saveTaskByAPIResult:(JsonAPIResult *)apiResult;
+ (void)updateTasklistByAPIResult:(JsonAPIResult *)apiResult;

@end
